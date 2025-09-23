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
        
        # Discover test cases
        runner = TestRunner(xslt_file, test_dir)
        test_cases = runner.discover_test_cases()
        
        if test_case:
            # Filter to specific test case
            test_cases = [tc for tc in test_cases if tc.name == test_case]
            if not test_cases:
                logger.error(f"Test case not found: {test_case}")
                return False
        
        if not test_cases:
            logger.error("No test cases found")
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
                
                # Get the XML expected output file path
                xml_expected_file = test_case_obj.expected_output_files.get('xml')
                if not xml_expected_file:
                    # Fallback for old test case structure or create default
                    xml_expected_file = str(Path(test_case_obj.input_file).parent / "expected_output.xml")
                
                # Write to expected output file
                with open(xml_expected_file, 'w', encoding='utf-8') as f:
                    f.write(output)
                
                logger.info(f"✓ Updated {xml_expected_file}")
                
                # Generate Turtle version if requested
                if generate_turtle:
                    xml_file = Path(xml_expected_file)
                    ttl_file = xml_file.with_suffix('.ttl')
                    if convert_xml_to_turtle(xml_file, ttl_file):
                        logger.info(f"✓ Generated {ttl_file.name}")
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
                
            xml_file = test_case_dir / "expected_output.xml"
            ttl_file = test_case_dir / "expected_output.ttl"
            
            if not xml_file.exists():
                logger.warning(f"No expected_output.xml found in {test_case_dir.name}")
                continue
                
            if ttl_file.exists():
                logger.info(f"Turtle file already exists for {test_case_dir.name}, skipping")
                continue
                
            if convert_xml_to_turtle(xml_file, ttl_file):
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