# Purpose and usage

This XSLT is a proof of concept for the implementation of the specification concerning GeoDCAT-AP, the geospatial profile of [DCAT-AP](https://joinup.ec.europa.eu/node/63567/), available on the [Interoperable Europe Portal](https://joinup.ec.europa.eu/collection/semic-support-centre/solution/geodcat-application-profile-data-portals-europe).
    
As such, this XSLT must be considered as unstable, and can be updated any time based on the revisions to the GeoDCAT-AP specifications and related work in the framework of [INSPIRE](http://inspire.ec.europa.eu/) and the [Interoperable Europe initiative](https://joinup.ec.europa.eu/interoperable-europe).

Comments and inquiries should be sent via the [issue tracker](https://github.com/SEMICeu/iso-19139-to-dcat-ap/issues/).

## Usage for High-Value Datasets (HVDs)

See [DCAT-AP HVD](https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd/) for the HVD technical requirements.
The XSLT has been updated to support the [HVD tagging good practice](https://github.com/INSPIRE-MIF/GeoDCAT-AP-pilot/tree/main/good-practices/hvd-tagging).
However, this only handles tagging on the Dataset level.
Implementers still need to add correct tagging to the Distribution (applicable legislation) and Data Service levels (applicable legislation and HVD category) for those distributions and data services of the dataset, which comply with the HVD IR.

## How to use the XSLT

Instructions on how to use the XSLT are available [in a separate page](./documentation/HowTo.md).

The XSLT in the `main` branch always corresponds to [the latest version of GeoDCAT-AP](https://semiceu.github.io/GeoDCAT-AP/releases/), and it can be directly used via the following URL:

https://raw.githubusercontent.com/SEMICeu/iso-19139-to-dcat-ap/main/iso-19139-to-dcat-ap.xsl

Previous releases are available from [the release page](https://github.com/SEMICeu/iso-19139-to-dcat-ap/releases).

## Testing the XSLT

### Automated Testing Framework

This repository includes a test framework for validating XSLT transformations.
The framework automatically tests the transformation with various configurations and validates outputs against expected results.

**Quick start:**
```bash
cd tests
pip install -r requirements.txt
python run_tests.py --verbose
```

The test framework includes:
- **Multiple test cases**: Dataset and service metadata transformations
- **Configuration testing**: Different GeoDCAT-AP profiles (core/extended)
- **Automated CI/CD**: GitHub Actions run tests on every commit
- **Semantic validation**: RDF graph comparison for accurate results

For detailed information, see the [testing documentation](./tests/README.md).

### Manual Testing with GeoDCAT-AP API

The API is no longer supported from version 3.0. The XSLT can be tested with any CSW endpoint and an XSLT 2.0 compliant processor.

# Content

* [`alignments/`](./alignments/): Folder including alignments between the controlled vocabularies used in ISO 19115 / INSPIRE metadata and those used in DCAT-AP.
* [`documentation/`](./documentation/): Folder containing documentation on the XSLT:
    * [`HowTo.md`](./documentation/HowTo.md): Describes how to use the XSLT.
    * [`HTTP-URIs.md`](./documentation/HTTP-URIs.md): Provides the list of transformation rules currently implemented for identifying HTTP URIs embedded in ISO 19139 metadata records.
    * [`Mappings.md`](./documentation/Mappings.md): Provides a summary of the mappings from ISO 19139 to GeoDCAT-AP.
* [`tests/`](./tests/): Test framework for validating XSLT transformations:
    * [`README.md`](./tests/README.md): Comprehensive guide to the testing framework.
    * [`run_tests.py`](./tests/run_tests.py): Python script for running test cases.
    * [`test-cases/`](./tests/test-cases/): Directory containing test input/output pairs.
* [`CHANGELOG.md`](./CHANGELOG.md): Log of changes made to the XSLT.
* [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl): The code of the XSLT.
* [`LICENCE.md`](./LICENCE.md): The XSLT's licence.
* [`README.md`](./README.md): This document.