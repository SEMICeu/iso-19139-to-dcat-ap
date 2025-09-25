#!/usr/bin/env python3
"""
Test runner for ISO 19139 to DCAT-AP XSLT transformation.

This script runs test cases against the XSLT transformation and compares
the output with expected results using semantic RDF graph comparison.

Features:
- Automatic test case discovery
- Semantic RDF comparison (supports XML and Turtle formats)
- Remote input URL support for testing real-world metadata
- Configurable XSLT parameters via JSON configuration
- Comprehensive test reporting
"""

import os
import sys
import tempfile
import logging
import argparse
import json
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass
from saxonche import PySaxonProcessor
from rdflib import Graph, compare
from urllib.request import urlretrieve
from urllib.error import URLError
import ssl

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

@dataclass
class TestCase:
    """Represents a single test case."""
    name: str
    input_file: str
    expected_output_files: Dict[str, str] = None  # format -> file_path mapping
    parameters: Dict[str, str] = None
    description: str = ""
    
    def __post_init__(self):
        if self.parameters is None:
            self.parameters = {}
        if self.expected_output_files is None:
            self.expected_output_files = {}

@dataclass
class SkippedTestCase:
    """Represents a skipped test case."""
    name: str
    reason: str
    description: str = ""

@dataclass
class TestResult:
    """Represents the result of running a test case."""
    test_case: TestCase
    passed: bool
    actual_output: str = ""
    error_message: str = ""
    execution_time: float = 0.0

class XSLTTransformer:
    """Handles XSLT transformations using SaxonC."""

    def __init__(self, xslt_file: str):
        """Initialize the transformer with an XSLT file.
        
        Args:
            xslt_file: Path or URL to the XSLT file
        """
        logger.debug(f"Initializing XSLTTransformer with xslt_file: {xslt_file}")
        
        self.xslt_path = xslt_file
        if xslt_file.startswith('http://') or xslt_file.startswith('https://'):
            # Download XSLT file if it's a URL
            temp_path = os.path.join(tempfile.gettempdir(), "iso19139-to-geodcatap.xsl")
            if not os.path.isfile(temp_path):
                logger.info(f"Downloading XSLT file from URL: {xslt_file}")
                # Disable SSL verification for self-signed certificates
                ssl_context = ssl.create_default_context()
                ssl_context.check_hostname = False
                ssl_context.verify_mode = ssl.CERT_NONE
                urlretrieve(xslt_file, temp_path)
            self.xslt_path = temp_path
        
        if not os.path.isfile(self.xslt_path):
            raise FileNotFoundError(f"XSLT file not found: {self.xslt_path}")
        
        self.processor = PySaxonProcessor(license=False)
        self.xslt_processor = self.processor.new_xslt30_processor()

    def transform(self, xml_file: str, parameters: Dict[str, str] = None) -> str:
        """Transform an XML file using the XSLT.
        
        Args:
            xml_file: Path to the input XML file
            parameters: XSLT parameters
            
        Returns:
            Transformed XML as string
            
        Raises:
            Exception: If transformation fails
        """
        try:
            logger.debug(f"Transforming file: {xml_file}")
            
            # Load and compile XSLT
            xslt_executable = self.xslt_processor.compile_stylesheet(stylesheet_file=self.xslt_path)
            
            # Set parameters if provided
            if parameters:
                for key, value in parameters.items():
                    xslt_executable.set_parameter(key, self.processor.make_string_value(value))
                    logger.debug(f"Set parameter {key}={value}")
            
            # Transform
            result = xslt_executable.transform_to_string(source_file=xml_file)
            
            if result is None:
                raise Exception("Transformation returned None")
                
            logger.debug("Transformation completed successfully")
            return result
            
        except Exception as e:
            logger.error(f"Transformation failed: {str(e)}")
            raise

class TestRunner:
    """Runs XSLT test cases."""

    def __init__(self, xslt_file: str, test_dir: str):
        """Initialize the test runner.
        
        Args:
            xslt_file: Path or URL to the XSLT file
            test_dir: Directory containing test cases
        """
        self.transformer = XSLTTransformer(xslt_file)
        self.test_dir = Path(test_dir)
        
    def discover_test_cases(self) -> Tuple[List[TestCase], List[SkippedTestCase]]:
        """Discover test cases in the test directory.
        
        Returns:
            Tuple of (valid_test_cases, skipped_test_cases)
        """
        test_cases = []
        skipped_cases = []
        test_cases_dir = self.test_dir / "test-cases"
        
        if not test_cases_dir.exists():
            logger.warning(f"Test cases directory not found: {test_cases_dir}")
            return test_cases, skipped_cases
        
        for test_case_dir in test_cases_dir.iterdir():
            if not test_case_dir.is_dir():
                continue

            input_file = test_case_dir / "input.xml"
            config_file = test_case_dir / "config.json"

            # Look for expected output files in different formats
            expected_files = {}
            rdf_file = test_case_dir / "expected_output.rdf"
            ttl_file = test_case_dir / "expected_output.ttl"

            if rdf_file.exists():
                expected_files["RDF/XML"] = str(rdf_file)
            if ttl_file.exists():
                expected_files["turtle"] = str(ttl_file)

            # Load test configuration if available
            parameters = {}
            description = ""
            if config_file.exists():
                try:
                    with open(config_file, 'r') as f:
                        config = json.load(f)
                        parameters = config.get('parameters', {})
                        description = config.get('description', '')
                except Exception as e:
                    logger.warning(f"Failed to load config for {test_case_dir.name}: {e}")

            # Check if test case is complete
            if not input_file.exists() or not expected_files:
                reasons = []
                if not input_file.exists():
                    reasons.append("missing input.xml")
                if not expected_files:
                    reasons.append("missing expected output files")

                reason = f"incomplete test case ({', '.join(reasons)})"
                logger.warning(f"Skipping {test_case_dir.name}: {reason}")

                skipped_case = SkippedTestCase(
                    name=test_case_dir.name,
                    reason=reason,
                    description=description
                )
                skipped_cases.append(skipped_case)
                continue

            test_case = TestCase(
                name=test_case_dir.name,
                input_file=str(input_file),
                expected_output_files=expected_files,
                parameters=parameters,
                description=description
            )
            test_cases.append(test_case)
            logger.debug(f"Discovered test case: {test_case.name} with formats: {list(expected_files.keys())}")
        
        return test_cases, skipped_cases
    
    def run_test_case(self, test_case: TestCase) -> TestResult:
        """Run a single test case.
        
        Args:
            test_case: The test case to run
            
        Returns:
            Test result
        """
        import time
        start_time = time.time()
        
        try:
            logger.info(f"Running test case: {test_case.name}")
            
            # Transform the input
            actual_output = self.transformer.transform(
                test_case.input_file, 
                test_case.parameters
            )
            
            # Compare with expected outputs
            passed = self._compare_rdf_outputs(actual_output, test_case.expected_output_files)
            
            execution_time = time.time() - start_time
            
            result = TestResult(
                test_case=test_case,
                passed=passed,
                actual_output=actual_output,
                execution_time=execution_time
            )
            
            if passed:
                logger.info(f"✓ Test case {test_case.name} PASSED ({execution_time:.2f}s)")
            else:
                logger.error(f"✗ Test case {test_case.name} FAILED ({execution_time:.2f}s)")
                
            return result
            
        except Exception as e:
            execution_time = time.time() - start_time
            error_msg = str(e)
            logger.error(f"✗ Test case {test_case.name} ERROR: {error_msg} ({execution_time:.2f}s)")
            
            return TestResult(
                test_case=test_case,
                passed=False,
                error_message=error_msg,
                execution_time=execution_time
            )
    
    def _compare_rdf_outputs(self, actual_output: str, expected_files: Dict[str, str]) -> bool:
        """Compare RDF outputs for semantic equality.

        Args:
            actual_output: The actual transformation output (RDF/XML)
            expected_files: Dictionary mapping format names to file paths

        Returns:
            True if outputs are semantically equivalent
        """
        try:
            # Parse actual output as RDF/XML
            actual_graph = Graph()
            actual_graph.parse(data=actual_output, format="xml")

            # Try to compare with each expected format
            for format_name, expected_file in expected_files.items():
                try:
                    expected_graph = Graph()

                    # Determine RDFLib format from our format name
                    if format_name == "RDF/XML":
                        rdf_format = "xml"
                    elif format_name == "turtle":
                        rdf_format = "turtle"
                    else:
                        logger.warning(f"Unknown format: {format_name}, skipping")
                        continue

                    expected_graph.parse(expected_file, format=rdf_format)

                    # Compare graph isomorphism
                    if compare.isomorphic(actual_graph, expected_graph):
                        logger.debug(f"RDF comparison passed using {format_name} format")
                        return True
                    else:
                        logger.debug(f"RDF comparison failed with {format_name} format")

                except Exception as e:
                    logger.warning(f"Failed to parse expected output {expected_file} as {format_name}: {e}")
                    continue

            # If we get here, none of the expected formats matched
            logger.warning("RDF comparison failed with all available expected formats")
            return False

        except Exception as e:
            logger.warning(f"RDF comparison failed completely: {e}")
            # Fallback to XML string comparison if we have an RDF/XML expected file
            if "RDF/XML" in expected_files:
                return self._normalize_xml(actual_output) == self._normalize_xml_file(expected_files["RDF/XML"])
            return False
    
    def _normalize_xml(self, xml_content: str) -> str:
        """Normalize XML content for comparison."""
        try:
            from xml.etree import ElementTree as ET
            root = ET.fromstring(xml_content)
            # Sort attributes and elements for consistent comparison
            return ET.tostring(root, encoding='unicode')
        except:
            # Fallback to simple string normalization
            return ' '.join(xml_content.split())
    
    def _normalize_xml_file(self, xml_file: str) -> str:
        """Normalize XML file content for comparison."""
        with open(xml_file, 'r', encoding='utf-8') as f:
            return self._normalize_xml(f.read())
    
    def run_all_tests(self) -> Tuple[List[TestResult], List[SkippedTestCase]]:
        """Run all discovered test cases.
        
        Returns:
            Tuple of (test_results, skipped_test_cases)
        """
        test_cases, skipped_cases = self.discover_test_cases()
        
        if not test_cases and not skipped_cases:
            logger.warning("No test cases found")
            return [], []
        
        if skipped_cases:
            logger.info(f"Found {len(skipped_cases)} skipped test case(s)")
        
        if test_cases:
            logger.info(f"Running {len(test_cases)} test cases")
            results = []
            
            for test_case in test_cases:
                result = self.run_test_case(test_case)
                results.append(result)
            
            return results, skipped_cases
        else:
            logger.warning("No runnable test cases found")
            return [], skipped_cases
    
    def generate_report(self, results: List[TestResult], skipped_cases: List[SkippedTestCase] = None, output_file: Optional[str] = None) -> str:
        """Generate a test report.
        
        Args:
            results: List of test results
            skipped_cases: List of skipped test cases
            output_file: Optional file to write the report to
            
        Returns:
            Report content as string
        """
        if skipped_cases is None:
            skipped_cases = []
            
        passed_count = sum(1 for r in results if r.passed)
        failed_count = len(results) - passed_count
        skipped_count = len(skipped_cases)
        total_discovered = len(results) + skipped_count
        total_time = sum(r.execution_time for r in results)
        
        # Prepare report sections
        summary_lines = [
            "=" * 60,
            "ISO 19139 to DCAT-AP XSLT Test Report",
            "=" * 60,
            f"Total discovered: {total_discovered}",
            f"Tests run: {len(results)}",
            f"Passed: {passed_count}",
            f"Failed: {failed_count}",
            f"Skipped: {skipped_count}",
            f"Total execution time: {total_time:.2f}s",
            ""
        ]

        skipped_lines = []
        if skipped_count > 0:
            skipped_lines.extend([
                "SKIPPED TESTS:",
                "-" * 20
            ])
            for skipped in skipped_cases:
                skipped_lines.append(f"• {skipped.name}")
                skipped_lines.append(f"  Reason: {skipped.reason}")
                if skipped.description:
                    skipped_lines.append(f"  Description: {skipped.description}")
                skipped_lines.append("")

        failed_lines = []
        if failed_count > 0:
            failed_lines.extend([
                "FAILED TESTS:",
                "-" * 20
            ])
            for result in results:
                if not result.passed:
                    failed_lines.append(f"• {result.test_case.name}")
                    if result.error_message:
                        failed_lines.append(f"  Error: {result.error_message}")
                    failed_lines.append("")

        detailed_lines = []
        if len(results) > 0:
            detailed_lines.extend([
                "DETAILED RESULTS:",
                "-" * 20
            ])
            for result in results:
                status = "PASS" if result.passed else "FAIL"
                detailed_lines.append(f"{result.test_case.name}: {status} ({result.execution_time:.2f}s)")
                if result.test_case.description:
                    detailed_lines.append(f"  Description: {result.test_case.description}")
                if result.error_message:
                    detailed_lines.append(f"  Error: {result.error_message}")
                detailed_lines.append("")

        # Print detailed results first, then skipped/failed, then summary
        report_content = "\n".join(detailed_lines + skipped_lines + failed_lines + summary_lines)
        
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(report_content)
            logger.info(f"Report written to {output_file}")
        
        return report_content

    def transform_remote_input(self, remote_url: str, output_file: str = None, parameters: Dict[str, str] = None) -> str:
        """Transform a remote ISO 19139 XML file.
        
        Args:
            remote_url: URL to the remote ISO 19139 XML file
            output_file: Optional output file path
            parameters: Optional XSLT parameters
            
        Returns:
            Transformation result as string
        """
        logger.info(f"Downloading remote input from: {remote_url}")
        
        # Create SSL context that doesn't verify certificates (for testing)
        ssl_context = ssl.create_default_context()
        ssl_context.check_hostname = False
        ssl_context.verify_mode = ssl.CERT_NONE
        
        # Download the remote file
        with tempfile.NamedTemporaryFile(mode='w+b', suffix='.xml', delete=False) as temp_file:
            try:
                # Set up SSL context for HTTPS URLs
                import urllib.request
                opener = urllib.request.build_opener(urllib.request.HTTPSHandler(context=ssl_context))
                urllib.request.install_opener(opener)
                
                urlretrieve(remote_url, temp_file.name)
                logger.debug(f"Downloaded to temporary file: {temp_file.name}")
                
                # Transform the downloaded file
                logger.info("Transforming remote input...")
                result = self.transformer.transform(temp_file.name, parameters or {})
                
                # Save to output file if specified
                if output_file:
                    with open(output_file, 'w', encoding='utf-8') as f:
                        f.write(result)
                    logger.info(f"Transformation result saved to: {output_file}")
                
                return result
                
            except Exception as e:
                logger.error(f"Failed to download or transform remote input: {e}")
                raise
            finally:
                # Clean up temporary file
                try:
                    os.unlink(temp_file.name)
                except OSError:
                    pass

def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(description="Run ISO 19139 to DCAT-AP XSLT tests")
    parser.add_argument(
        "--xslt",
        default="../iso-19139-to-dcat-ap.xsl",
        help="Path or URL to the XSLT file (default: ../iso-19139-to-dcat-ap.xsl)"
    )
    parser.add_argument(
        "--test-dir",
        default=".",
        help="Directory containing test cases (default: current directory)"
    )
    parser.add_argument(
        "--report",
        help="Output file for test report"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose logging"
    )
    parser.add_argument(
        "--test-case",
        help="Run only a specific test case by name"
    )
    parser.add_argument(
        "--remote-input",
        help="URL to remote ISO 19139 XML file to transform (bypasses test cases)"
    )
    parser.add_argument(
        "--output",
        help="Output file for transformation result (used with --remote-input)"
    )
    parser.add_argument(
        "--profile",
        choices=["core", "extended"],
        default="extended",
        help="XSLT profile to use with --remote-input (default: extended)"
    )
    parser.add_argument(
        "--include-deprecated",
        choices=["yes", "no"],
        default="no",
        help="Include deprecated mappings with --remote-input (default: no)"
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    try:
        # Initialize test runner
        runner = TestRunner(args.xslt, args.test_dir)
        
        # Handle remote input transformation
        if args.remote_input:
            logger.info("Running transformation on remote input")
            parameters = {
                "profile": args.profile,
                "include-deprecated": args.include_deprecated,
                "CoupledResourceLookup": "disabled"
            }
            result = runner.transform_remote_input(
                args.remote_input, 
                args.output,
                parameters=parameters
            )
            
            if not args.output:
                # Print result to stdout if no output file specified
                print("=" * 60)
                print("TRANSFORMATION RESULT")
                print("=" * 60)
                print(result)
            
            logger.info("Remote transformation completed successfully")
            return
        
        # Run tests
        if args.test_case:
            # Run specific test case
            test_cases, skipped_cases = runner.discover_test_cases()
            test_case = next((tc for tc in test_cases if tc.name == args.test_case), None)
            
            # Check if the requested test case is skipped
            skipped_case = next((sc for sc in skipped_cases if sc.name == args.test_case), None)
            
            if test_case:
                results = [runner.run_test_case(test_case)]
                test_skipped_cases = []
            elif skipped_case:
                logger.error(f"Test case '{args.test_case}' is skipped: {skipped_case.reason}")
                results = []
                test_skipped_cases = [skipped_case]
            else:
                logger.error(f"Test case not found: {args.test_case}")
                sys.exit(1)
        else:
            # Run all test cases
            results, test_skipped_cases = runner.run_all_tests()
        
        if not results and not test_skipped_cases:
            logger.error("No tests were found")
            sys.exit(1)
        
        # Generate and display report
        report = runner.generate_report(results, test_skipped_cases, args.report)
        print(report)
        
        # Exit with non-zero code if any tests failed
        failed_count = sum(1 for r in results if not r.passed)
        if failed_count > 0:
            sys.exit(1)
        
    except Exception as e:
        logger.error(f"Test runner failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()