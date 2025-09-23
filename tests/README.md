# ISO 19139 to DCAT-AP XSLT Tests

This directory contains test cases and infrastructure for validating the ISO 19139 to DCAT-AP XSLT transformation.

## Overview

The test framework consists of:
- **Test cases**: Input XML files and expected RDF/XML outputs
- **Test runner**: Python script that executes transformations and compares results
- **GitHub Actions**: Automated testing on each commit
- **Configuration**: Test-specific parameters and settings

## Test Structure

```
tests/
├── run_tests.py           # Main test runner script
├── requirements.txt       # Python dependencies
├── README.md             # This file
└── test-cases/           # Test case directory
    ├── basic_dataset/    # Test case for basic dataset metadata
    │   ├── input.xml         # Input ISO 19139 metadata
    │   ├── expected_output.xml  # Expected DCAT-AP RDF/XML output
    │   └── config.json       # Test configuration (optional)
    └── service_metadata/ # Test case for service metadata
        ├── input.xml
        ├── expected_output.xml
        └── config.json
```

## Running Tests

### Prerequisites

1. **Python 3.12** with pip
2. **Required Python packages** (install via requirements.txt)

```bash
pip install -r requirements.txt
```

### Basic Usage

```bash
# Run all tests
python run_tests.py

# Run with verbose output
python run_tests.py --verbose

# Run a specific test case
python run_tests.py --test-case basic_dataset

# Generate a test report
python run_tests.py --report test_report.txt

# Transform a remote ISO 19139 XML file
python run_tests.py --remote-input "https://example.com/metadata.xml" --output result.xml

# Transform remote file with specific profile and parameters
python run_tests.py --remote-input "https://example.com/metadata.xml" --profile core --include-deprecated yes --output result.xml
```

### Available Options

- `--xslt`: Path to the XSLT file (default: ../iso-19139-to-dcat-ap.xsl)
- `--test-dir`: Directory containing test cases (default: current directory)
- `--report`: Output file for test report
- `--verbose`: Enable verbose logging
- `--test-case`: Run only a specific test case by name
- `--remote-input`: URL to remote ISO 19139 XML file to transform (bypasses test cases)
- `--output`: Output file for transformation result (used with --remote-input)
- `--profile`: XSLT profile to use with --remote-input (core/extended, default: extended)
- `--include-deprecated`: Include deprecated mappings with --remote-input (yes/no, default: no)

## Creating New Test Cases

To add a new test case:

1. **Create a new directory** under `test-cases/` with a descriptive name
2. **Add input.xml** - Your ISO 19139 metadata record
3. **Add expected outputs** - Choose one or both formats:
   - `expected_output.xml` - Expected DCAT-AP RDF/XML output
   - `expected_output.ttl` - Expected DCAT-AP Turtle output (more readable)
4. **Add config.json** (optional) - Test-specific configuration

**Note:** Both XML and Turtle expected outputs are supported. The test runner uses semantic RDF comparison, so both formats should represent the same RDF graph. Use `update_expected.py --turtle-only` to generate Turtle versions from existing XML files.

### Example config.json

```json
{
    "description": "Test description",
    "parameters": {
        "profile": "extended",
        "CoupledResourceLookup": "disabled",
        "include-deprecated": "no"
    }
}
```

### Available XSLT Parameters

- `profile`: "core" or "extended" (default: "extended")
- `CoupledResourceLookup`: "enabled" or "disabled" (default: "enabled" for extended, "disabled" for core)
- `include-deprecated`: "yes" or "no" (default: "yes")

## Updating Expected Outputs

The `update_expected.py` script provides utilities to regenerate expected outputs:

### Update All Expected Outputs

Regenerate all expected outputs (XML and Turtle formats) by running the XSLT:

```bash
python update_expected.py --confirm
```

### Update Specific Test Case

Update only a specific test case:

```bash
python update_expected.py --test-case basic_dataset --confirm
```

### Skip Turtle Generation

Generate only XML expected outputs (skip Turtle):

```bash
python update_expected.py --no-turtle --confirm
```

### Generate Turtle Files Only

Convert existing XML expected outputs to Turtle format without re-running XSLT:

```bash
python update_expected.py --turtle-only
```

⚠️ **Warning**: These commands will overwrite existing expected output files!

## Expected Output Formats

Test cases support dual-format expected outputs for better maintainability:

- **`expected_output.xml`**: RDF/XML format (compact, machine-readable)
- **`expected_output.ttl`**: Turtle format (human-readable, better for diffs)

Both formats are semantically equivalent and validated using RDF graph comparison.

## Test Validation

The test runner performs semantic comparison of RDF graphs using the RDFLib library. This ensures that:
- **Graph isomorphism** is checked (structural equivalence)
- **Namespace prefixes** don't affect comparison
- **Element ordering** doesn't affect comparison
- **Whitespace differences** are ignored

If RDF parsing fails, the system falls back to normalized XML string comparison.

## Continuous Integration

Tests are automatically run via GitHub Actions on:
- **Push to main/develop branches**
- **Pull requests to main branch**

The CI pipeline:
1. **Discovers test cases dynamically**
2. **Validates XML and JSON fixture files**
3. **Runs XSLT transformation tests** (using config.json profiles)
4. **Generates comprehensive test reports**

## Troubleshooting

### Common Issues

1. **Saxon license errors**: The tests use the free Saxon-HE edition. Ensure you're not using Saxon-PE/EE features.

2. **RDF comparison failures**: If semantic comparison fails, check:
   - Both XML files are valid RDF/XML
   - Namespace declarations are correct
   - No syntax errors in the expected output

4. **XSLT transformation errors**: Check:
   - Input XML is valid ISO 19139
   - XSLT file is accessible and valid
   - Parameters are correctly formatted

### Debug Mode

Run with `--verbose` flag to see detailed execution information:

```bash
python run_tests.py --verbose
```

### Manual Testing

To manually test a transformation:

```python
from run_tests import XSLTTransformer

transformer = XSLTTransformer('../iso-19139-to-dcat-ap.xsl')
output = transformer.transform('test-cases/basic_dataset/input.xml')
print(output)
```

## Contributing

When contributing new test cases:

1. **Follow naming conventions**: Use descriptive directory names
2. **Include documentation**: Add description in config.json
3. **Validate inputs**: Ensure XML files are well-formed
4. **Test thoroughly**: Run your test case before submitting
5. **Update documentation**: Add your test case to this README

## Dependencies

- **saxonche**: XSLT 3.0 processor
- **rdflib**: RDF graph parsing and comparison
- **PyYAML**: YAML configuration parsing (future use)

## License

This test framework follows the same license as the main project (EUPL-1.2).