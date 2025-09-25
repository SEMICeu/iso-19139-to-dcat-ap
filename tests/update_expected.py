#!/usr/bin/env python3
"""
Utility script to update expected outputs for test cases.

This script runs the XSLT transformation on all test input files and
updates the expected output files. Use this when the XSLT has been
updated and you need to regenerate the expected outputs.

WARNING: This will overwrite existing expected output files!
"""

import os
import sys
import argparse
import logging
from pathlib import Path
from run_tests import XSLTTransformer, TestRunner
from rdflib import Graph

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

def convert_xml_to_turtle(xml_file: Path, ttl_file: Path) -> bool:
    """Convert RDF/XML file to Turtle format.
    
    Args:
        xml_file: Path to the RDF/XML file
        ttl_file: Path where to save the Turtle file
        
    Returns:
        True if conversion was successful
    """
    try:
        # Parse RDF/XML
        graph = Graph()
        graph.parse(xml_file, format="xml")
        
        # Serialize as Turtle with nice formatting
        turtle_content = graph.serialize(format="turtle")
        
        # Write to file
        with open(ttl_file, 'w', encoding='utf-8') as f:
            f.write(turtle_content)
            
        logger.info(f"Converted {xml_file.name} -> {ttl_file.name}")
        return True
        
    except Exception as e:
        logger.error(f"Failed to convert {xml_file}: {e}")
        return False

def discover_updateable_test_cases(test_dir: str, specific_test_case: str = None):
    """Discover test cases that can be updated (including those with missing expected outputs).
    
    Args:
        test_dir: Directory containing test cases
        specific_test_case: Optional specific test case name to find
        
    Returns:
        List of test cases that have input files (expected outputs will be created)
    """
    from run_tests import TestCase
    import json
    
    test_cases = []
    test_cases_dir = Path(test_dir) / "test-cases"
    
    if not test_cases_dir.exists():
        logger.error("test-cases directory not found")
        return test_cases
    
    for test_case_dir in test_cases_dir.iterdir():
        if not test_case_dir.is_dir():
            continue
            
        # Skip if we're looking for a specific test case and this isn't it
        if specific_test_case and test_case_dir.name != specific_test_case:
            continue
            
        input_file = test_case_dir / "input.xml"
        config_file = test_case_dir / "config.json"
        
        # We only need input.xml to be able to update/create expected outputs
        if not input_file.exists():
            logger.warning(f"Skipping {test_case_dir.name}: no input.xml found")
            continue
        
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
        
        # Create expected output files dict (may be empty, will be populated)
        expected_files = {}
        rdf_file = test_case_dir / "expected_output.rdf"
        ttl_file = test_case_dir / "expected_output.ttl"

        if rdf_file.exists():
            expected_files["RDF/XML"] = str(rdf_file)
        if ttl_file.exists():
            expected_files["turtle"] = str(ttl_file)
        
        test_case = TestCase(
            name=test_case_dir.name,
            input_file=str(input_file),
            expected_output_files=expected_files,
            parameters=parameters,
            description=description
        )
        test_cases.append(test_case)
        
        status = "existing expected outputs" if expected_files else "will create expected outputs"
        logger.debug(f"Found updateable test case: {test_case.name} ({status})")
    
    return test_cases

def update_expected_outputs(xslt_file: str, test_dir: str, test_case: str = None, generate_turtle: bool = True):
    """Update expected output files for test cases.
    
    Args:
        xslt_file: Path or URL to the XSLT file
        test_dir: Directory containing test cases
        test_case: Optional specific test case to update
        generate_turtle: Whether to also generate Turtle versions
    """
    try:
        # Initialize transformer
        transformer = XSLTTransformer(xslt_file)
        
        # Discover updateable test cases (including those with missing expected outputs)
        test_cases = discover_updateable_test_cases(test_dir, test_case)
        
        if test_case and not test_cases:
            logger.error(f"Test case not found or has no input.xml: {test_case}")
            return False
        
        if not test_cases:
            logger.error("No updateable test cases found")
            return False
        
        logger.info(f"Updating expected outputs for {len(test_cases)} test case(s)")
        
        success_count = 0
        for test_case_obj in test_cases:
            try:
                logger.info(f"Processing test case: {test_case_obj.name}")
                
                # Transform the input
                output = transformer.transform(
                    test_case_obj.input_file,
                    test_case_obj.parameters
                )
                
                # Determine the RDF/XML expected output file path
                rdf_expected_file = test_case_obj.expected_output_files.get('RDF/XML')
                if not rdf_expected_file:
                    # Create path for new expected output file
                    rdf_expected_file = str(Path(test_case_obj.input_file).parent / "expected_output.rdf")

                # Write to expected output file (create or update)
                with open(rdf_expected_file, 'w', encoding='utf-8') as f:
                    f.write(output)

                action = "Updated" if test_case_obj.expected_output_files.get('RDF/XML') else "Created"
                logger.info(f"✓ {action} {rdf_expected_file}")

                # Generate Turtle version if requested
                if generate_turtle:
                    rdf_file = Path(rdf_expected_file)
                    ttl_file = rdf_file.with_suffix('.ttl')
                    if convert_xml_to_turtle(rdf_file, ttl_file):
                        ttl_action = "Updated" if test_case_obj.expected_output_files.get('turtle') else "Created"
                        logger.info(f"✓ {ttl_action} {ttl_file.name}")
                    else:
                        logger.warning(f"✗ Failed to generate Turtle for {test_case_obj.name}")
                
                success_count += 1
                
            except Exception as e:
                logger.error(f"✗ Failed to update {test_case_obj.name}: {e}")
        
        logger.info(f"Successfully updated {success_count}/{len(test_cases)} test cases")
        return success_count == len(test_cases)
        
    except Exception as e:
        logger.error(f"Update failed: {e}")
        return False

def generate_turtle_only(test_dir: str, test_case: str = None):
    """Generate Turtle versions of existing XML expected outputs.
    
    Args:
        test_dir: Directory containing test cases
        test_case: Optional specific test case to process
        
    Returns:
        True if all conversions were successful
    """
    try:
        test_cases_dir = Path(test_dir) / "test-cases"
        
        if not test_cases_dir.exists():
            logger.error("test-cases directory not found")
            return False
        
        converted_count = 0
        failed_count = 0
        
        # Process each test case directory
        for test_case_dir in test_cases_dir.iterdir():
            if not test_case_dir.is_dir():
                continue
            
            # Filter to specific test case if requested
            if test_case and test_case_dir.name != test_case:
                continue
                
            rdf_file = test_case_dir / "expected_output.rdf"
            ttl_file = test_case_dir / "expected_output.ttl"

            if not rdf_file.exists():
                logger.warning(f"No expected_output.rdf found in {test_case_dir.name}")
                continue

            if ttl_file.exists():
                logger.info(f"Turtle file already exists for {test_case_dir.name}, skipping")
                continue

            if convert_xml_to_turtle(rdf_file, ttl_file):
                converted_count += 1
            else:
                failed_count += 1
        
        logger.info(f"Conversion complete: {converted_count} successful, {failed_count} failed")
        return failed_count == 0
        
    except Exception as e:
        logger.error(f"Turtle generation failed: {e}")
        return False

def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Update expected outputs for XSLT test cases and generate Turtle versions",
        epilog="WARNING: This will overwrite existing expected output files! Use --turtle-only to only convert XML to Turtle."
    )
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
        "--test-case",
        help="Update only a specific test case by name"
    )
    parser.add_argument(
        "--no-turtle",
        action="store_true",
        help="Skip generation of Turtle (.ttl) versions of expected outputs"
    )
    parser.add_argument(
        "--turtle-only",
        action="store_true",
        help="Only generate Turtle files from existing XML expected outputs (don't run XSLT)"
    )
    parser.add_argument(
        "--confirm",
        action="store_true",
        help="Skip confirmation prompt"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose logging"
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    # Handle turtle-only mode
    if args.turtle_only:
        if args.no_turtle:
            logger.error("Cannot use --turtle-only with --no-turtle")
            sys.exit(1)
            
        logger.info("Running in turtle-only mode (converting existing XML to Turtle)")
        success = generate_turtle_only(args.test_dir, args.test_case)
        
        if success:
            print("\n✓ All Turtle files generated successfully!")
        else:
            print("\n✗ Some conversions failed. Check the logs above.")
            sys.exit(1)
        return
    
    # Confirmation prompt for XSLT updates
    if not args.confirm:
        print("WARNING: This will overwrite existing expected output files!")
        if args.test_case:
            print(f"Test case to update: {args.test_case}")
        else:
            print("All test cases will be updated.")
        
        response = input("Do you want to continue? (y/N): ").strip().lower()
        if response not in ['y', 'yes']:
            print("Operation cancelled.")
            sys.exit(0)
    
    # Update expected outputs
    success = update_expected_outputs(args.xslt, args.test_dir, args.test_case, not args.no_turtle)
    
    if success:
        print("\n✓ All expected outputs updated successfully!")
        print("\nNext steps:")
        print("1. Review the updated files with 'git diff'")
        print("2. Run tests to verify: 'python run_tests.py'")
        print("3. Commit the changes if they look correct")
    else:
        print("\n✗ Some updates failed. Check the logs above.")
        sys.exit(1)

if __name__ == "__main__":
    main()