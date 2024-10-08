# Purpose and usage

This XSLT is a proof of concept for the implementation of the specification concerning GeoDCAT-AP, the geospatial profile of [DCAT-AP](https://joinup.ec.europa.eu/node/63567/), available on the [Interoperable Europe Portal](https://joinup.ec.europa.eu/collection/semic-support-centre/solution/geodcat-application-profile-data-portals-europe).
    
As such, this XSLT must be considered as unstable, and can be updated any time based on the revisions to the GeoDCAT-AP specifications and related work in the framework of [INSPIRE](http://inspire.ec.europa.eu/) and the [Interoperable Europe initiative](https://joinup.ec.europa.eu/interoperable-europe).

Comments and inquiries should be sent via the [issue tracker](https://github.com/SEMICeu/iso-19139-to-dcat-ap/issues/).

## Usage for High-Value Datasets (HVDs)

Note that this XSLT, or its output, needs to be adjusted by each data publisher to produce HVD compliant metadata records.
Especially the areas of Data Service identification, License information and Persistent Identifiers are not covered by this proof-of-concept.
See [DCAT-AP HVD](https://semiceu.github.io/DCAT-AP/releases/3.0.0-hvd/) for the HVD technical requirements.

## How to use the XSLT

Instructions on how to use the XSLT are available [in a separate page](./documentation/HowTo.md).

The XSLT in the `main` branch always corresponds to [the latest version of GeoDCAT-AP](https://semiceu.github.io/GeoDCAT-AP/releases/), and it can be directly used via the following URL:

https://raw.githubusercontent.com/SEMICeu/iso-19139-to-dcat-ap/main/iso-19139-to-dcat-ap.xsl

Previous releases are available from [the release page](https://github.com/SEMICeu/iso-19139-to-dcat-ap/releases).

## Testing the XSLT with the GeoDCAT-AP API

The API is no longer supported from version 3.0. The XSLT can be tested with any CSW endpoint and an XSLT 2.0 compliant processor.

# Content

* [`alignments/`](./alignments/): Folder including alignments between the controlled vocabularies used in ISO 19115 / INSPIRE metadata and those used in DCAT-AP.
* [`documentation/`](./documentation/): Folder containing documentation on the XSLT:
    * [`HowTo.md`](./documentation/HowTo.md): Describes how to use the XSLT.
    * [`HTTP-URIs.md`](./documentation/HTTP-URIs.md): Provides the list of transformation rules currently implemented for identifying HTTP URIs embedded in ISO 19139 metadata records.
    * [`Mappings.md`](./documentation/Mappings.md): Provides a summary of the mappings from ISO 19139 to GeoDCAT-AP.
* [`CHANGELOG.md`](./CHANGELOG.md): Log of changes made to the XSLT.
* [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl): The code of the XSLT.
* [`LICENCE.md`](./LICENCE.md): The XSLT's licence.
* [`README.md`](./README.md): This document.