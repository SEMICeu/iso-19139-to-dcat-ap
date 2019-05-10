# Purpose and usage

This XSLT is a proof of concept for the implementation of the specification concerning the geospatial profile of [DCAT-AP](https://joinup.ec.europa.eu/node/63567/) (GeoDCAT-AP), available on Joinup, the collaboration platform of the [EU ISA Programme](http://ec.europa.eu/isa):
  
<https://joinup.ec.europa.eu/solution/geodcat-ap>
    
As such, this XSLT must be considered as unstable, and can be updated any time based on the revisions to the GeoDCAT-AP specifications and related work in the framework of [INSPIRE](http://inspire.ec.europa.eu/) and the EU ISA Programme.

Comments and inquiries should be sent via the [issue tracker](https://github.com/SEMICeu/iso-19139-to-dcat-ap/issues/).

# Content

* [`alignments/`](./alignments/): Folder including alignments between the controlled vocabularies used in ISO 19115 / INSPIRE metadata and those used in DCAT-AP.
* [`api/`](./api/): Proof-of-concept of the implementation of GeoDCAT-AP following the CSW interface.
* [`documentation/`](./documentation/): Folder containing documentation on the XSLT:
    * [`HowTo.md`](./documentation/HowTo.md): Describes how to use the XSLT.
    * [`HTTP-URIs.md`](./documentation/HTTP-URIs.md): Provides the list of transformation rules currently implemented for identifying HTTP URIs embedded in ISO 19139 metadata records.
    * [`Mappings.md`](./documentation/Mappings.md): Provides a summary of the mappings from ISO 19139 to GeoDCAT-AP.
* [`CHANGELOG.md`](./CHANGELOG.md): Log of changes made to the XSLT.
* [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl): The code of the XSLT.
* [`LICENCE.md`](./LICENCE.md): The XSLT's licence.
* [`README.md`](./README.md): This document. 
  
#  Credits
  
This work is supported by the [EU Interoperability Solutions for European Public Administrations Programme (ISA)](http://ec.europa.eu/isa) through [Action 1.17: Re-usable INSPIRE Reference Platform (ARe3NA)](http://ec.europa.eu/isa/actions/01-trusted-information-exchange/1-17action_en.htm).
