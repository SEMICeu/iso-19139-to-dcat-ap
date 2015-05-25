# Mappings defined in GeoDCAT-AP

This documents illustrates the mappings defined in GeoDCAT-AP, as implemented in the [`iso-19139-to-dcat-ap.xsl`](../iso-19139-to-dcat-ap.xsl) XSLT.

This document is organised in the following sections:

*   Used namespaces
*   Reference code lists for metadata elements
*   Mapping summary
    *   Metadata on metadata for INSPIRE data sets, data set series, and services
    *   Resource metadata common to data sets, data set series, and services
    *   Resource metadata specific to data sets and data set series
    *   Resource metadata specific to services
*   Mappings of individual metadata elements (TBD)

## Used namespaces

<table border="1">

<thead>

<tr>

<th>Prefix</th>

<th>Namespace URI</th>

<th>Schema & documentation</th>

</tr>

</thead>

<tbody>

<tr>

<td>`adms`</td>

<td>`[http://www.w3.org/ns/adms#](http://www.w3.org/ns/adms#)`</td>

<td>[Asset Description Metadata Schema](http://www.w3.org/TR/2013/NOTE-vocab-adms-20130801/ "ADMS")</td>

</tr>

<tr>

<td>`cnt`</td>

<td>`[http://www.w3.org/2011/content#](http://www.w3.org/2011/content#)`</td>

<td>[Representing Content in RDF 1.0](http://www.w3.org/TR/2011/WD-Content-in-RDF10-20110510/)</td>

</tr>

<tr>

<td>`dc`</td>

<td>`[http://purl.org/dc/elements/1.1/](http://purl.org/dc/elements/1.1/)`</td>

<td>[Dublin Core Metadata Element Set, Version 1.1](http://dublincore.org/documents/2012/06/14/dces/)</td>

</tr>

<tr>

<td>`dcat`</td>

<td>`[http://www.w3.org/ns/dcat](http://www.w3.org/ns/dcat#)`</td>

<td>[Data Catalog Vocabulary](http://www.w3.org/TR/2014/REC-vocab-dcat-20140116/ "DCAT")</td>

</tr>

<tr>

<td>`dct`</td>

<td>`[http://purl.org/dc/terms/](http://purl.org/dc/terms/)`</td>

<td>[DCMI Metadata Terms](http://dublincore.org/documents/2012/06/14/dcmi-terms/)</td>

</tr>

<tr>

<td>`foaf`</td>

<td>`[http://xmlns.com/foaf/0.1/](http://xmlns.com/foaf/0.1/)`</td>

<td>[FOAF Vocabulary](http://xmlns.com/foaf/spec/20140114.html)</td>

</tr>

<tr>

<td>`gsp`</td>

<td>`[http://www.opengis.net/ont/geosparql#](http://www.opengis.net/ont/geosparql#)`</td>

<td>[GeoSPARQL - A Geographic Query Language for RDF Data](http://www.opengeospatial.org/standards/geosparql)</td>

</tr>

<tr>

<td>`locn`</td>

<td>`[http://www.w3.org/ns/locn#](http://www.w3.org/ns/locn#)`</td>

<td>[ISA Programme Core Location Vocabulary](http://www.w3.org/ns/locn)</td>

</tr>

<tr>

<td>`prov`</td>

<td>`[http://www.w3.org/ns/prov#](http://www.w3.org/ns/prov#)`</td>

<td>[PROV-O: The PROV Ontology](http://www.w3.org/TR/2013/REC-prov-o-20130430/)</td>

</tr>

<tr>

<td>`rdf`</td>

<td>`[http://www.w3.org/1999/02/22-rdf-syntax-ns#](http://www.w3.org/1999/02/22-rdf-syntax-ns#)`</td>

<td>[Resource Description Framework (RDF): Concepts and Abstract Syntax](http://www.w3.org/TR/2004/REC-rdf-concepts-20040210/)</td>

</tr>

<tr>

<td>`rdfs`</td>

<td>`[http://www.w3.org/2000/01/rdf-schema#](http://www.w3.org/2000/01/rdf-schema#)`</td>

<td>[RDF Vocabulary Description Language 1.0: RDF Schema](http://www.w3.org/TR/2004/REC-rdf-schema-20040210/)</td>

</tr>

<tr>

<td>`schema`</td>

<td>`[http://schema.org/](http://schema.org/)`</td>

<td>[schema.org](http://schema.org/)</td>

</tr>

<tr>

<td>`skos`</td>

<td>`[http://www.w3.org/2004/02/skos/core#](http://www.w3.org/2004/02/skos/core#)`</td>

<td>[SKOS Simple Knowledge Organization System - Reference](http://www.w3.org/TR/2009/REC-skos-reference-20090818/)</td>

</tr>

<tr>

<td>`vcard`</td>

<td>`[http://www.w3.org/2006/vcard/ns#](http://www.w3.org/2006/vcard/ns#)`</td>

<td>[vCard Ontology](http://www.w3.org/TR/2013/WD-vcard-rdf-20130924/)</td>

</tr>

<tr>

<td>`xsd`</td>

<td>`[http://www.w3.org/2001/XMLSchema#](http://www.w3.org/2001/XMLSchema)`</td>

<td>[XML Schema Part 2: Datatypes Second Edition](http://www.w3.org/TR/2004/REC-xmlschema-2-20041028/)</td>

</tr>

</tbody>

</table>

## Reference code lists for metadata elements

For a number of INSPIRE metadata elements, this document proposes the use of URI code list registers. These registers include:

*   Code lists defined in the INSPIRE Metadata Regulation [[INSPIRE-MD-REG](http://eur-lex.europa.eu/eli/reg/com/2008/1205)], and made available through the URI registers operated by the INSPIRE Registry [[INSPIRE-REGISTRY](http://inspire.ec.europa.eu/registry/)].
*   URI registers operated by the Publications Office of the EU, whose use is recommended in DCAT-AP.

<table border="1">

<thead>

<tr>

<th>Metadata elements (ISO 19115 / INSPIRE)</th>

<th>Code list URI</th>

<th>Code lists</th>

<th>Status</th>

</tr>

</thead>

<tbody>

<tr>

<td>Metadata language</td>

<td rowspan="2">`[http://publications.europa.eu/resource/authority/language](http://publications.europa.eu/resource/authority/language)`</td>

<td rowspan="2">Language register operated by the Metadata Registry of the Publications Office of the EU [[MDR-LANG](http://publications.europa.eu/mdr/authority/language/)]</td>

<td rowspan="2">stable</td>

</tr>

<tr>

<td>Resource language</td>

</tr>

<tr>

<td>Resource type</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/ResourceType](http://inspire.ec.europa.eu/metadata-codelist/ResourceType)`</td>

<td>Register operated by the INSPIRE Registry for resource types defined in ISO 19115</td>

<td>stable</td>

</tr>

<tr>

<td>Service type</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceType](http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceType)`</td>

<td>Register operated by the INSPIRE Registry for service types, as defined in [[INSPIRE-MD-REG](http://eur-lex.europa.eu/eli/reg/com/2008/1205)]</td>

<td>stable</td>

</tr>

<tr>

<td>Topic category</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/TopicCategory](http://inspire.ec.europa.eu/metadata-codelist/TopicCategory)`</td>

<td>Register operated by the INSPIRE Registry for topic categories defined in ISO 19115</td>

<td>stable</td>

</tr>

<tr>

<td>Keyword denoting one of the INSPIRE spatial data themes</td>

<td>`[http://inspire.ec.europa.eu/theme](http://inspire.ec.europa.eu/theme)`</td>

<td>INSPIRE spatial data theme register operated by the INSPIRE Registry</td>

<td>stable</td>

</tr>

<tr>

<td>Keyword denoting one of the spatial data service categories</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceCategory](http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceCategory)`</td>

<td>Register operated by the INSPIRE Registry for spatial data service categories defined in ISO 19119</td>

<td>stable</td>

</tr>

<tr>

<td>Degree of conformity</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/DegreeOfConformity](http://inspire.ec.europa.eu/metadata-codelist/DegreeOfConformity)`</td>

<td>Register operated by the INSPIRE Registry for degrees of conformity, as defined in [[INSPIRE-MD-REG](http://eur-lex.europa.eu/eli/reg/com/2008/1205)]</td>

<td>stable</td>

</tr>

<tr>

<td>Responsible party role</td>

<td>`[http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole](http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole)`</td>

<td>Register operated by the INSPIRE Registry for responsible party roles, as defined in [[INSPIRE-MD-REG](http://eur-lex.europa.eu/eli/reg/com/2008/1205)]</td>

<td>stable</td>

</tr>

<tr>

<td rowspan="2">Format / Encoding</td>

<td>`[http://publications.europa.eu/resource/authority/file-type](http://publications.europa.eu/resource/authority/file-type)`</td>

<td>File type register operated by the Metadata Registry of the Publications Office of the EU [[MDR-FT](http://publications.europa.eu/mdr/authority/file-type/)]</td>

<td>stable</td>

</tr>

<tr>

<td>`[http://inspire.ec.europa.eu/media-types](http://inspire.ec.europa.eu/media-types)`</td>

<td>Register of media types used for datasets in INSPIRE download services</td>

<td>testing</td>

</tr>

<tr>

<td rowspan="2">Maintenance frequency (Maintenance information)</td>

<td>[`http://purl.org/cld/freq/`](http://purl.org/cld/freq/)</td>

<td>Dublin Core Collection Description Frequency Vocabulary [[DC-CLD-FREQ](http://dublincore.org/groups/collections/frequency/)]</td>

<td>stable</td>

</tr>

<tr>

<td>`http://inspire.ec.europa.eu/metadata-codelist/MaintenanceFrequencyCode`</td>

<td>Register operated by the INSPIRE Registry for maintenance frequency codes defined in ISO 19115 (not yet available)</td>

<td>testing</td>

</tr>

<tr>

<td>Spatial representation type</td>

<td>`http://inspire.ec.europa.eu/metadata-codelist/SpatialRepresentationTypeCode`</td>

<td>Register operated by the INSPIRE Registry for spatial representation type codes defined in ISO 19115 (not yet available)</td>

<td>testing</td>

</tr>

</tbody>

</table>

## Mapping summary

The following sections provide a summary of the alignments defined in GeoDCAT-AP.

The alignments are grouped as follows:

*   Alignment for metadata records (metadata on metadata)
*   Alignments for resource metadata common to datasets, series and services
*   Alignments for resource metadata specific to datasets and series
*   Alignments for resource metadata specific to services

The alignments supported only in the extended profile of GeoDCAT-AP are in **bold**.

### Metadata on metadata for INSPIRE data sets, data set series, and services

The domain of the mappings is `dcat:CatalogRecord`.

<table border="1">

<thead>

<tr>

<th colspan="2" rowspan="2">Metadata elements (ISO 19115 / INSPIRE)</th>

<th colspan="2">Mappings</th>

<th rowspan="2">Mapping status</th>

<th rowspan="2">Comments</th>

</tr>

<tr>

<th>Property and/or attribute</th>

<th>Range</th>

</tr>

</thead>

<tbody>

<tr>

<td colspan="2" rowspan="2">Metadata point of contact</td>

<td>**`prov:qualifiedAttribution`**</td>

<td>**`prov:Attribution`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td>**`dcat:contactPoint`**</td>

<td>**`vcard:Kind`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td colspan="2">Metadata date</td>

<td>`dct:modified`</td>

<td>`xsd:date`</td>

<td>testing</td>

</tr>

<tr>

<td colspan="2">Metadata language</td>

<td>`dct:language`</td>

<td>`dct:LinguisticSystem`</td>

<td>stable</td>

</tr>

</tbody>

</table>

### Resource metadata common to data sets, data set series, and services

As a rule, the domain of the mappings is either `dcat:Dataset` (when the element is used for datasets and series) or `dctype:Service` / `dcat:Catalog` (when the element is used for services). However, “starred” elements – i.e., elements whose name is preceded by an asterisk (“*”) – are those having as domain either `dcat:Distribution` (when the element is used for datasets and series) or `dctype:Service` / `dcat:Catalog` (when the element is used for services).

<table border="1">

<thead>

<tr>

<th colspan="2" rowspan="2">Metadata elements (ISO 19115 / INSPIRE)</th>

<th colspan="2">Mappings</th>

<th rowspan="2">Mapping status</th>

<th rowspan="2">Comments</th>

</tr>

<tr>

<th>Property</th>

<th>Range</th>

</tr>

</thead>

<tbody>

<tr>

<td colspan="2">Resource title</td>

<td>`dct:title`</td>

<td>`rdf:PlainLiteral`</td>

<td>stable</td>

</tr>

<tr>

<td colspan="2">Resource abstract</td>

<td>`dct:description`</td>

<td>`rdf:PlainLiteral`</td>

<td>stable</td>

</tr>

<tr>

<td rowspan="5">Resource type</td>

<td>_Any type_</td>

<td>**`dct:type`**</td>

<td>**`skos:Concept`**</td>

<td>stable</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td>Data set</td>

<td rowspan="4">`rdf:type`</td>

<td rowspan="2">`dcat:Dataset`</td>

<td rowspan="2">stable</td>

</tr>

<tr>

<td>Data set series</td>

</tr>

<tr>

<td rowspan="2">Service</td>

<td>`dcat:Catalog`</td>

<td>stable</td>

<td>For catalogue / discovery services</td>

</tr>

<tr>

<td>**`dctype:Service`**</td>

<td>stable</td>

<td>For all the other services. Only for the extended profile</td>

</tr>

<tr>

<td colspan="2">Spatial extent</td>

<td>`dct:spatial`</td>

<td>`dct:Location`</td>

<td>stable</td>

<td>Spatial extent / coverage is specified as a geographic identifier and/or bounding box - see below</td>

</tr>

<tr>

<td rowspan="4">Spatial extent: Geographic identifier</td>

<td rowspan="3">Code</td>

<td>`dct:spatial`</td>

<td>`rdfs:Resource` (URI reference)</td>

<td>stable</td>

<td>If the geographic identifier is an HTTP URI.</td>

</tr>

<tr>

<td>`dct:identifier`</td>

<td>`xsd:anyURI`</td>

<td>stable</td>

<td>If the geographic identifier is a URN. The domain is `dct:Location`</td>

</tr>

<tr>

<td>`skos:prefLabel`</td>

<td>`rdf:PlainLiteral`</td>

<td>stable</td>

<td>If the geographic identifier is a textual label. The domain is `dct:Location`</td>

</tr>

<tr>

<td>Authority</td>

<td>`skos:inScheme`</td>

<td>`skos:ConceptScheme`</td>

<td>stable</td>

<td>If the geographic identifier is an HTTP URI, the information about the authority is omitted. The domain is `dct:Location`</td>

</tr>

<tr>

<td colspan="2">Spatial extent: Geographic bounding box</td>

<td>`locn:geometry`</td>

<td>`locn:Geometry` (`rdfs:Literal` or `rdfs:Class`)</td>

<td>stable</td>

<td>The recommendation is to use WKT or GML literals, encoded as per the GeoSPARQL specification. The domain is `dct:Location`</td>

</tr>

<tr>

<td rowspan="4">Temporal reference</td>

<td>Temporal extent</td>

<td>`dct:temporal`</td>

<td>`dct:PeriodOfTime`</td>

<td>stable</td>

</tr>

<tr>

<td>Date of publication</td>

<td>`dct:issued`</td>

<td>`xsd:date`</td>

<td>stable</td>

</tr>

<tr>

<td>Date of last revision</td>

<td>`dct:modified`</td>

<td>`xsd:date`</td>

<td>stable</td>

</tr>

<tr>

<td>Date of creation</td>

<td>**`dct:created`**</td>

<td>**`xsd:date`**</td>

<td>stable</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td colspan="2">Spatial resolution</td>

<td>**`rdfs:comment`**</td>

<td>**`rdf:PlainLiteral`**</td>

<td>unstable</td>

<td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>

</tr>

<tr>

<td rowspan="4">Conformance result / Conformity (Data quality)</td>

<td>_Any degree_</td>

<td>**`prov:wasUsedBy`**</td>

<td>**`prov:Activity`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td>Conformant</td>

<td>`dct:conformsTo`</td>

<td>`dct:Standard`</td>

<td>stable</td>

</tr>

<tr>

<td>Not conformant</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Not evaluated</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td colspan="2">* Use limitation / Conditions for access and use</td>

<td>``dct:license``</td>

<td>`dct:LicenseDocument`</td>

<td>testing</td>

<td>For datasets and dataset series, the domain is `dcat:Distribution`.</td>

</tr>

<tr>

<td colspan="2">* Access constraints, other constraints / Limitations on public access</td>

<td>`dct:accessRights`</td>

<td>`dct:RightsStatement`</td>

<td>testing</td>

<td>For datasets and dataset series, the domain is `dcat:Distribution`.</td>

</tr>

<tr>

<td rowspan="12">Responsible organisation</td>

<td>_Any role_</td>

<td>**`prov:qualifiedAttribution`**</td>

<td>**`prov:Attribution`**</td>

<td>unstable</td>

<td>Only for the extended profile.</td>

</tr>

<tr>

<td>Resource provider</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Custodian</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Owner</td>

<td>**`dct:rightsHolder`**</td>

<td>**`foaf:Agent`**</td>

<td>stable</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td>User</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Distributor</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Originator</td>

<td>`dct:creator`</td>

<td>`foaf:Agent`</td>

<td>testing</td>

</tr>

<tr>

<td>Point of contact</td>

<td>`dcat:contactPoint`</td>

<td>`vcard:Kind`</td>

<td>stable</td>

</tr>

<tr>

<td>Principal investigator</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Processor</td>

<td>-</td>

<td>-</td>

</tr>

<tr>

<td>Publisher</td>

<td>`dct:publisher`</td>

<td>`foaf:Agent`</td>

<td>stable</td>

</tr>

<tr>

<td>Author</td>

<td>-</td>

<td>-</td>

</tr>

</tbody>

</table>

### Resource metadata specific to data sets and data set series

As a rule, the domain of the mappings is `dcat:Dataset`. However, “starred” elements – i.e., elements whose name is preceded by an asterisk (“*”) – are those having as domain `dcat:Distribution`.

<table border="1">

<thead>

<tr>

<th rowspan="2" colspan="2">Metadata elements</th>

<th colspan="2">Mappings</th>

<th rowspan="2">Mapping status</th>

<th rowspan="2">Comments</th>

</tr>

<tr>

<th>Property and/or attribute</th>

<th>Range</th>

</tr>

</thead>

<tbody>

<tr>

<td rowspan="6">Online resource / Resource locator</td>

<td>* Download</td>

<td>`dcat:accessURL`</td>

<td>`rdfs:Resource`</td>

<td>stable</td>

<td>The domain is `dcat:Distribution`</td>

</tr>

<tr>

<td>Information</td>

<td>`foaf:page`</td>

<td>`foaf:Document`</td>

<td>testing</td>

</tr>

<tr>

<td>* Offline access</td>

<td>`dcat:accessURL`</td>

<td>`rdfs:Resource`</td>

<td>testing</td>

<td>The domain is `dcat:Distribution`</td>

</tr>

<tr>

<td>* Order</td>

<td>`dcat:accessURL`</td>

<td>`rdfs:Resource`</td>

<td>testing</td>

<td>The domain is `dcat:Distribution`</td>

</tr>

<tr>

<td>Search</td>

<td>`foaf:page`</td>

<td>`foaf:Document`</td>

<td>testing</td>

</tr>

<tr>

<td>_missing_</td>

<td>`dcat:landingPage`</td>

<td>`foaf:Document`</td>

<td>stable</td>

</tr>

<tr>

<td colspan="2">Resource identifier / Unique resource identifier</td>

<td>`dct:identifier`</td>

<td>`rdfs:Literal`</td>

<td>testing</td>

</tr>

<tr>

<td colspan="2">Resource language</td>

<td>`dct:language`</td>

<td>`dct:LinguisticSystem`</td>

<td>stable</td>

</tr>

<tr>

<td rowspan="2" colspan="2">Keyword</td>

<td>`dcat:theme`</td>

<td>`skos:Concept`</td>

<td>stable</td>

<td>For keywords from controlled vocabularies (as the INSPIRE spatial data themes and GEMET)</td>

</tr>

<tr>

<td>`dcat:keyword`</td>

<td>`rdfs:Literal`</td>

<td>stable</td>

<td>For free text keywords</td>

</tr>

<tr>

<td colspan="2">Topic category</td>

<td>`dct:subject`</td>

<td>`skos:Concept`</td>

<td>unstable</td>

</tr>

<tr>

<td colspan="2">Maintenance frequency (Maintenance information)</td>

<td>`dct:accrualPeriodicity`</td>

<td>`rdfs:Resource`</td>

<td>stable</td>

</tr>

<tr>

<td colspan="2">Lineage</td>

<td>`dct:provenance`</td>

<td>`dct:ProvenanceStatement`</td>

<td>stable</td>

</tr>

<tr>

<td colspan="2">Coordinate reference system</td>

<td>**`dct:conformsTo`**</td>

<td>**`rdfs:Resource`**</td>

<td>unstable</td>

<td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>

</tr>

<tr>

<td colspan="2">Temporal reference system</td>

<td>**`dct:conformsTo`**</td>

<td>**`rdfs:Resource`**</td>

<td>unstable</td>

<td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>

</tr>

<tr>

<td colspan="2">Spatial representation type</td>

<td>**`adms:representationTechnique`**</td>

<td>**`rdfs:Resource`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td colspan="2">* Encoding</td>

<td>`dcat:mediaType`</td>

<td>`dct:MediaTypeOrExtent`</td>

<td>testing</td>

</tr>

<tr>

<td colspan="2">* Character encoding</td>

<td>`cnt:characterEncoding`</td>

<td>`rdfs:Literal`</td>

<td>testing</td>

</tr>

</tbody>

</table>

### Resource metadata specific to services

The domain of the mappings is `dcat:Catalog` for catalogue / discovery service, and `dctype:Service` for all the other services.

<table border="1">

<thead>

<tr>

<th rowspan="2" colspan="2">Metadata elements</th>

<th colspan="2">Mappings</th>

<th rowspan="2">Mapping status</th>

<th rowspan="2">Comments</th>

</tr>

<tr>

<th>Property and/or attribute</th>

<th>Range</th>

</tr>

</thead>

<tbody>

<tr>

<td>Online resource / Resource locator</td>

<td>_Any function_</td>

<td>`foaf:homepage`</td>

<td>`foaf:Document`</td>

<td>testing</td>

</tr>

<tr>

<td colspan="2">Coupled resource</td>

<td>**`dct:hasPart`**</td>

<td>**`dcat:Dataset`**</td>

<td>stable</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td colspan="2">Spatial data service type</td>

<td>**`dct:type`**</td>

<td>**`skos:Concept`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

<tr>

<td colspan="2" rowspan="3">Keyword</td>

<td>**`dct:type`**</td>

<td>**`skos:Concept`**</td>

<td>testing</td>

<td>Only for the extended profile. For spatial data service categories defined in ISO 19119</td>

</tr>

<tr>

<td>**`dct:subject`**</td>

<td>**`skos:Concept`**</td>

<td>testing</td>

<td>Only for the extended profile. For keywords from controlled vocabularies (as the INSPIRE spatial data themes and GEMET)</td>

</tr>

<tr>

<td>**`dc:subject`**</td>

<td>**`rdfs:Literal`**</td>

<td>testing</td>

<td>Only for the extended profile. For free text keywords</td>

</tr>

<tr>

<td colspan="2">Spatial data service category</td>

<td>**`dct:type`**</td>

<td>**`skos:Concept`**</td>

<td>testing</td>

<td>Only for the extended profile</td>

</tr>

</tbody>

</table>
