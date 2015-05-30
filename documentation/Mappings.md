<h1>Mappings defined in GeoDCAT-AP</a></h1>

<p>This documents illustrates the mappings defined in GeoDCAT-AP, as implemented in the [`iso-19139-to-dcat-ap.xsl`](../iso-19139-to-dcat-ap.xsl) XSLT.

<p>This document is organised in the following sections:</p>

<ul>
  <li><a href="#used-namespaces">Used namespaces</a></li>
  <li><a href="#ref-code-lists">Reference code lists for metadata elements</a></li>
  <li><a href="#mapping-summary">Mapping summary</a>
    <ul>
      <li><a href="#md-on-md">Metadata on metadata for INSPIRE data sets, data set series, and services</a></li>
      <li><a href="#md-common">Resource metadata common to data sets, data set series, and services</a></li>
      <li><a href="#md-specific-data">Resource metadata specific to data sets and data set series</a></li>
      <li><a href="#md-specific-service">Resource metadata specific to services</a></li>
    </ul>
  </li>
  <li><a href="#mapping-individual">Mappings of individual metadata elements</a>
    <ul>
      <li><a href="#mapping-geo-id">Geographic identifier</a></li>
      <li><a href="#mapping-bbox">Geographic bounding box</a></li>
      <li><a href="#mapping-conformance-result">Conformance result / Conformity (Data quality)</a></li>
      <li><a href="#mapping-responsible-party">Responsible party</a></li>
      <li><a href="#">...</a></li>
    </ul>
  </li>
</ul>

<h2><a name="used-namespaces">Used namespaces</a></h2>

<table>
  <thead>
    <tr>
      <th>Prefix</th>
      <th>Namespace URI</th>
      <th>Schema &amp; documentation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>adms</code></td>
      <td><code><a href="http://www.w3.org/ns/adms#">http://www.w3.org/ns/adms#</a></code></td>
      <td><a href="http://www.w3.org/TR/2013/NOTE-vocab-adms-20130801/" title="ADMS">Asset Description Metadata Schema</a></td>
    </tr>
    <tr>
      <td><code>cnt</code></td>
      <td><code><a href="http://www.w3.org/2011/content#">http://www.w3.org/2011/content#</a></code></td>
      <td><a href="http://www.w3.org/TR/2011/WD-Content-in-RDF10-20110510/">Representing Content in RDF 1.0</a></td>
    </tr>
    <tr>
      <td><code>dc</code></td>
      <td><code><a href="http://purl.org/dc/elements/1.1/">http://purl.org/dc/elements/1.1/</a></code></td>
      <td><a href="http://dublincore.org/documents/2012/06/14/dces/">Dublin Core Metadata Element Set, Version 1.1</a></td>
    </tr>
    <tr>
      <td><code>dcat</code></td>
      <td><code><a href="http://www.w3.org/ns/dcat#">http://www.w3.org/ns/dcat</a></code></td>
      <td><a href="http://www.w3.org/TR/2014/REC-vocab-dcat-20140116/" title="DCAT">Data Catalog Vocabulary</a></td>
    </tr>
    <tr>
      <td><code>dct</code></td>
      <td><code><a href="http://purl.org/dc/terms/">http://purl.org/dc/terms/</a></code></td>
      <td><a href="http://dublincore.org/documents/2012/06/14/dcmi-terms/">DCMI Metadata Terms</a></td>
    </tr>
<!--    
    <tr>
      <td><code>earl</code></td>
      <td><code><a href="http://www.w3.org/ns/earl#">http://www.w3.org/ns/earl#</a></code></td>
      <td><a href="http://www.w3.org/TR/2011/WD-EARL10-Schema-20110510/">Evaluation and Report Language (EARL) 1.0</a></td>
    </tr>
-->
    <tr>
      <td><code>foaf</code></td>
      <td><code><a href="http://xmlns.com/foaf/0.1/">http://xmlns.com/foaf/0.1/</a></code></td>
      <td><a href="http://xmlns.com/foaf/spec/20140114.html">FOAF Vocabulary</a></td>
    </tr>
    <tr>
      <td><code>gsp</code></td>
      <td><code><a href="http://www.opengis.net/ont/geosparql#">http://www.opengis.net/ont/geosparql#</a></code></td>
      <td><a href="http://www.opengeospatial.org/standards/geosparql">GeoSPARQL - A Geographic Query Language for RDF Data</a></td>
    </tr>
    <tr>
      <td><code>locn</code></td>
      <td><code><a href="http://www.w3.org/ns/locn#">http://www.w3.org/ns/locn#</a></code></td>
      <td><a href="http://www.w3.org/ns/locn">ISA Programme Core Location Vocabulary</a></td>
    </tr>
    <tr>
      <td><code>owl</code></td>
      <td><code><a href="http://www.w3.org/2002/07/owl#">http://www.w3.org/2002/07/owl#</a></code></td>
      <td><a href="http://www.w3.org/TR/2004/REC-owl-ref-20040210/">OWL Web Ontology Language Reference</a></td>
    </tr>
    <tr>
      <td><code>prov</code></td>
      <td><code><a href="http://www.w3.org/ns/prov#">http://www.w3.org/ns/prov#</a></code></td>
      <td><a href="http://www.w3.org/TR/2013/REC-prov-o-20130430/">PROV-O: The PROV Ontology</a></td>
    </tr>
    <tr>
      <td><code>rdf</code></td>
      <td><code><a href="http://www.w3.org/1999/02/22-rdf-syntax-ns#">http://www.w3.org/1999/02/22-rdf-syntax-ns#</a></code></td>
      <td><a href="http://www.w3.org/TR/2004/REC-rdf-concepts-20040210/">Resource Description Framework (RDF): Concepts and Abstract Syntax</a></td>
    </tr>
    <tr>
      <td><code>rdfs</code></td>
      <td><code><a href="http://www.w3.org/2000/01/rdf-schema#">http://www.w3.org/2000/01/rdf-schema#</a></code></td>
      <td><a href="http://www.w3.org/TR/2004/REC-rdf-schema-20040210/">RDF Vocabulary Description Language 1.0: RDF Schema</a></td>
    </tr>
    <tr>
      <td><code>schema</code></td>
      <td><code><a href="http://schema.org/">http://schema.org/</a></code></td>
      <td><a href="http://schema.org/">schema.org</a></td>
    </tr>
    <tr>
      <td><code>skos</code></td>
      <td><code><a href="http://www.w3.org/2004/02/skos/core#">http://www.w3.org/2004/02/skos/core#</a></code></td>
      <td><a href="http://www.w3.org/TR/2009/REC-skos-reference-20090818/">SKOS Simple Knowledge Organization System - Reference</a></td>
    </tr>
    <tr>
      <td><code>vcard</code></td>
      <td><code><a href="http://www.w3.org/2006/vcard/ns#">http://www.w3.org/2006/vcard/ns#</a></code></td>
      <td><a href="http://www.w3.org/TR/2013/WD-vcard-rdf-20130924/">vCard Ontology</a></td>
    </tr>
    <tr>
      <td><code>xsd</code></td>
      <td><code><a href="http://www.w3.org/2001/XMLSchema">http://www.w3.org/2001/XMLSchema#</a></code></td>
      <td><a href="http://www.w3.org/TR/2004/REC-xmlschema-2-20041028/">XML Schema Part 2: Datatypes Second Edition</a></td>
    </tr>
  </tbody>
</table>

<h2><a name="ref-code-lists">&star;</a>&nbsp;Reference code lists for metadata elements</h2>

<p>For a number of INSPIRE metadata elements, this document proposes the use of URI code list registers. These registers include:</p>
<ul>
  <li>Code lists defined in the INSPIRE Metadata Regulation [<a href="http://eur-lex.europa.eu/eli/reg/com/2008/1205">INSPIRE-MD-REG</a>], and made available through the URI registers operated by the INSPIRE Registry [<a href="http://inspire.ec.europa.eu/registry/">INSPIRE-REGISTRY</a>].</li>
  <li>URI registers operated by the Publications Office of the EU, whose use is recommended in DCAT-AP.</li>
</ul>

<table>
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
      <td rowspan="2"><code><a href="http://publications.europa.eu/resource/authority/language">http://publications.europa.eu/resource/authority/language</a></code></td>
      <td rowspan="2">Language register operated by the Metadata Registry of the Publications Office of the EU [<a href="http://publications.europa.eu/mdr/authority/language/">MDR-LANG</a>]</td>
      <td rowspan="2">stable</td>
    </tr>
    <tr>
      <td>Resource language</td>
    </tr>
    <tr>
      <td>Resource type</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/ResourceType">http://inspire.ec.europa.eu/metadata-codelist/ResourceType</a></code></td>
      <td>Register operated by the INSPIRE Registry for resource types defined in ISO 19115</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Service type</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceType">http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceType</a></code></td>
      <td>Register operated by the INSPIRE Registry for service types, as defined in [<a href="http://eur-lex.europa.eu/eli/reg/com/2008/1205">INSPIRE-MD-REG</a>]</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Topic category</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/TopicCategory">http://inspire.ec.europa.eu/metadata-codelist/TopicCategory</a></code></td>
      <td>Register operated by the INSPIRE Registry for topic categories defined in ISO 19115</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Keyword denoting one of the INSPIRE spatial data themes</td>
      <td><code><a href="http://inspire.ec.europa.eu/theme">http://inspire.ec.europa.eu/theme</a></code></td>
      <td>INSPIRE spatial data theme register operated by the INSPIRE Registry</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Keyword denoting one of the spatial data service categories</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceCategory">http://inspire.ec.europa.eu/metadata-codelist/SpatialDataServiceCategory</a></code></td>
      <td>Register operated by the INSPIRE Registry for spatial data service categories defined in ISO 19119</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Degree of conformity</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/DegreeOfConformity">http://inspire.ec.europa.eu/metadata-codelist/DegreeOfConformity</a></code></td>
      <td>Register operated by the INSPIRE Registry for degrees of conformity, as defined in [<a href="http://eur-lex.europa.eu/eli/reg/com/2008/1205">INSPIRE-MD-REG</a>]</td>
      <td>stable</td>
    </tr>
    <tr>
      <td>Responsible party role</td>
      <td><code><a href="http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole">http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole</a></code></td>
      <td>Register operated by the INSPIRE Registry for responsible party roles, as defined in [<a href="http://eur-lex.europa.eu/eli/reg/com/2008/1205">INSPIRE-MD-REG</a>]</td>
      <td>stable</td>
    </tr>
    <tr>
      <td rowspan="2">Format / Encoding</td>
      <td><code><a href="http://publications.europa.eu/resource/authority/file-type">http://publications.europa.eu/resource/authority/file-type</a></code></td>
      <td>File type register operated by the Metadata Registry of the Publications Office of the EU [<a href="http://publications.europa.eu/mdr/authority/file-type/">MDR-FT</a>]</td>
      <td>stable</td>
    </tr>
    <tr>
      <td><code><a href="http://inspire.ec.europa.eu/media-types">http://inspire.ec.europa.eu/media-types</a></code></td>
      <td>Register of media types used for datasets in INSPIRE download services</td>
      <td><em>testing</em></td>
    </tr>
    <tr>
      <td rowspan="2">Maintenance frequency (Maintenance information)</td>
      <td><a href="http://purl.org/cld/freq/"><code>http://purl.org/cld/freq/</code></a></td>
      <td>Dublin Core Collection Description Frequency Vocabulary [<a href="http://dublincore.org/groups/collections/frequency/">DC-CLD-FREQ</a>]</td>
      <td>stable</td>
    </tr>
    <tr>
      <td><code>http://inspire.ec.europa.eu/metadata-codelist/MaintenanceFrequencyCode</code></td>
      <td>Register operated by the INSPIRE Registry for maintenance frequency codes defined in ISO 19115 (not yet available)</td>
      <td><strong>unstable</strong></td>
    </tr>
    <tr>
      <td>Spatial representation type</td>
      <td><code>http://inspire.ec.europa.eu/metadata-codelist/SpatialRepresentationTypeCode</code></td>
      <td>Register operated by the INSPIRE Registry for spatial representation type codes defined in ISO 19115 (not yet available)</td>
      <td><strong>unstable</strong></td>
    </tr>
  </tbody>
</table>

<h2><a name="mapping-summary">Mapping summary</a></h2>

<p>The following sections provide a summary of the alignments defined in GeoDCAT-AP.</p>

<p>The alignments are grouped as follows:</p>
<ul>
<li>Alignment for metadata records (metadata on metadata)</li>
<li>Alignments for resource metadata common to datasets, series and services</li>
<li>Alignments for resource metadata specific to datasets and series</li>
<li>Alignments for resource metadata specific to services</li>
</ul>

<p>The alignments supported only in the extended profile of GeoDCAT-AP are in <strong>bold</strong>.</p>

<h3><a name="md-on-md">Metadata on metadata for INSPIRE data sets, data set series, and services</a></h3>
<p>The domain of the mappings is <code>dcat:CatalogRecord</code>, with the exception of metadata standard title and version, whose domain is <code>dct:Standard</code>.</p>

<table>
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
      <td><strong><code>prov:qualifiedAttribution</code><strong></td>
      <td><strong><code>prov:Attribution</code><strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td><strong><code>dcat:contactPoint</code><strong></td>
      <td><strong><code>vcard:Kind</code><strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2">Metadata date</td>
      <td><code>dct:modified</code></td>
      <td><code>xsd:date</code></td>
      <td><em>testing</em></td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Metadata language</td>
      <td><code>dct:language</code></td>
      <td><code>dct:LinguisticSystem</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Metadata file identifier</td>
      <td><strong><code>dct:identifier</code></strong></td>
      <td><strong><code>rdfs:Literal</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2">Metadata character encoding</td>
      <td><strong><code>cnt:characterEncoding</code></strong></td>
      <td><strong><code>rdfs:Literal</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2"><em>Metadata standard</em></td>
      <td><code>dct:conformsTo</code></td>
      <td><code>dct:Standard</code></td>
      <td>stable</td>
      <td>The metadata standard is modelled with <code>dct:Standard</code>, and it is described by a title and a version - see below</td>
    </tr>
    <tr>
      <td colspan="2">* Metadata standard name</td>
      <td><code>dct:title</code></td>
      <td><code>rdf:PlainLiteral</code></td>
      <td>stable</td>
      <td>The domain is <code>dct:Standard</code></td>
    </tr>
    <tr>
      <td colspan="2">* Metadata standard version</td>
      <td><code>owl:versionInfo</code></td>
      <td><code>rdf:PlainLiteral</code></td>
      <td>stable</td>
      <td>The domain is <code>dct:Standard</code></td>
    </tr>
  </tbody>
</table>

<h3><a name="md-common">Resource metadata common to data sets, data set series, and services</a></h3>
<p>As a rule, the domain of the mappings is either <code>dcat:Dataset</code> (when the element is used for datasets and series) or <code>dctype:Service</code> / <code>dcat:Catalog</code> (when the element is used for services). However, “starred” elements – i.e., elements whose name is preceded by an asterisk (“*”) – are those having as domain either <code>dcat:Distribution</code> (when the element is used for datasets and series) or <code>dctype:Service</code> / <code>dcat:Catalog</code> (when the element is used for services).</p>
<table>
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
      <td><code>dct:title</code></td>
      <td><code>rdf:PlainLiteral</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Resource abstract</td>
      <td><code>dct:description</code></td>
      <td><code>rdf:PlainLiteral</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="5">Resource type</td>
      <td><em>Any type</em></td>
      <td><strong><code>dct:type</code></strong></td>
      <td><strong><code>skos:Concept</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td>Data set</td>
      <td rowspan="4"><code>rdf:type</code></td>
      <td rowspan="2"><code>dcat:Dataset</code></td>
      <td rowspan="2">stable</td>
      <td rowspan="2"></td>
    </tr>
    <tr>
      <td>Data set series</td>
    </tr>
    <tr>
      <td rowspan="2">Service</td>
      <td><code>dcat:Catalog</code></td>
      <td>stable</td>
      <td>For catalogue / discovery services</td>
    </tr>
    <tr>
      <td><strong><code>dctype:Service</code></strong></td>
      <td>stable</td>
      <td>For all the other services. Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2"><em>Spatial extent</em></td>
      <td><code>dct:spatial</code></td>
      <td><code>dct:Location</code></td>
      <td>stable</td>
      <td>Spatial extent / coverage is specified as a geographic identifier and/or bounding box - see below</td>
    </tr>
    <tr>
      <td rowspan="4"><a href="#mapping-geo-id" title="see details">Spatial extent: Geographic identifier</a></td>
      <td rowspan="3">Code</td>
      <td><code>dct:spatial</code></td>
      <td><code>rdfs:Resource</code> (URI reference)</td>
      <td>stable</td>
      <td>If the geographic identifier is an HTTP URI.</code></td>
    </tr>
    <tr>
      <td><code>dct:identifier</code></td>
      <td><code>xsd:anyURI</code></td>
      <td>stable</td>
      <td>If the geographic identifier is a URN. The domain is <code>dct:Location</code></td>
    </tr>
    <tr>
      <td><code>skos:prefLabel</code></td>
      <td><code>rdf:PlainLiteral</code></td>
      <td>stable</td>
      <td>If the geographic identifier is a textual label. The domain is <code>dct:Location</code></td>
    </tr>
    <tr>
      <td>Authority</td>
      <td><code>skos:inScheme</code></td>
      <td><code>skos:ConceptScheme</code></td>
      <td>stable</td>
      <td>If the geographic identifier is an HTTP URI, the information about the authority is omitted. The domain is <code>dct:Location</code></td>
    </tr>
    <tr>
      <td colspan="2"><a href="#mapping-bbox" title="see details">Spatial extent: Geographic bounding box</a></td>
      <td><code>locn:geometry</code></td>
      <td><code>locn:Geometry</code> (<code>rdfs:Literal</code> or <code>rdfs:Class</code>)</td>
      <td>stable</td>
      <td>The recommendation is to use WKT or GML literals, encoded as per the GeoSPARQL specification. The domain is <code>dct:Location</code></td>
    </tr>
    <tr>
      <td rowspan="4">Temporal reference</td>
      <td>Temporal extent</td>
      <td><code>dct:temporal</code></td>
      <td><code>dct:PeriodOfTime</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td>Date of publication</td>
      <td><code>dct:issued</code></td>
      <td><code>xsd:date</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td>Date of last revision</td>
      <td><code>dct:modified</code></td>
      <td><code>xsd:date</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td>Date of creation</td>
      <td><strong><code>dct:created</code></strong></td>
      <td><strong><code>xsd:date</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2">Spatial resolution</td>
      <td><strong><code>rdfs:comment</code></strong></td>
      <td><strong><code>rdf:PlainLiteral</code></strong></td>
      <td><strong>unstable</strong></td>
      <td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>
    </tr>
    <tr>
      <td rowspan="4">Conformance result / Conformity (Data quality)</td>
      <td><em>Any degree</em></td>
      <td><strong><code>prov:wasUsedBy</code></strong></td>
      <td><strong><code>prov:Activity</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td>Conformant</td>
      <td><code>dct:conformsTo</code></td>
      <td><code>dct:Standard</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td>Not conformant</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Not evaluated</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2">* Use limitation / Conditions for access and use</td>
      <td><code>dct:license</code></td>
      <td><code>dct:LicenseDocument</code></td>
      <td><em>testing</em></td>
      <td>For datasets and dataset series, the domain is <code>dcat:Distribution</code>.</td>
    </tr>
    <tr>
      <td colspan="2">* Access constraints, other constraints / Limitations on public access</td>
      <td><code>dct:accessRights</code></td>
      <td><code>dct:RightsStatement</code></td>
      <td><em>testing</em></td>
      <td>For datasets and dataset series, the domain is <code>dcat:Distribution</code>.</td>
    </tr>
    <tr>
      <td rowspan="12">Responsible organisation</td>
      <td><em>Any role</em></td>
      <td><strong><code>prov:qualifiedAttribution</code></strong></td>
      <td><strong><code>prov:Attribution</code></strong></td>
      <td><strong>unstable</strong></td>
      <td>Only for the extended profile.</td>
    </tr>
    <tr>
      <td>Resource provider</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td></td>
    </tr>
    <tr>
      <td>Custodian</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Owner</td>
      <td><strong><code>dct:rightsHolder</code></strong></td>
      <td><strong><code>foaf:Agent</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td>User</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Distributor</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Originator</td>
      <td><code>dct:creator</code></td>
      <td><code>foaf:Agent</code></td>
      <td><em>testing</em></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Point of contact</td>
      <td><code>dcat:contactPoint</code></td>
      <td><code>vcard:Kind</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td>Principal investigator</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Processor</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Publisher</td>
      <td><code>dct:publisher</code></td>
      <td><code>foaf:Agent</code></td>
      <td>stable</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Author</td>
      <td>-</td>
      <td>-</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

<h3><a name="md-specific-data">Resource metadata specific to data sets and data set series</a></h3>
<p>As a rule, the domain of the mappings is <code>dcat:Dataset</code>. However, “starred” elements – i.e., elements whose name is preceded by an asterisk (“*”) – are those having as domain <code>dcat:Distribution</code>.</p>

<table>
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
      <td><code>dcat:accessURL</code></td>
      <td><code>rdfs:Resource</code></td>
      <td>stable</td>
      <td>The domain is <code>dcat:Distribution</code></td>
    </tr>
    <tr>
      <td>Information</td>
      <td><code>foaf:page</code></td>
      <td><code>foaf:Document</code></td>
      <td><em>testing</em></td>
      <td></td>
    </tr>
    <tr>
      <td>* Offline access</td>
      <td><code>dcat:accessURL</code></td>
      <td><code>rdfs:Resource</code></td>
      <td><em>testing</em></td>
      <td>The domain is <code>dcat:Distribution</code></td>
    </tr>
    <tr>
      <td>* Order</td>
      <td><code>dcat:accessURL</code></td>
      <td><code>rdfs:Resource</code></td>
      <td><em>testing</em></td>
      <td>The domain is <code>dcat:Distribution</code></td>
    </tr>
    <tr>
      <td>Search</td>
      <td><code>foaf:page</code></td>
      <td><code>foaf:Document</code></td>
      <td><em>testing</em></td>
      <td></td>
    </tr>
    <tr>
      <td><em>missing</em></td>
      <td><code>dcat:landingPage</code></td>
      <td><code>foaf:Document</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Resource identifier / Unique resource identifier</td>
      <td><code>dct:identifier</code></td>
      <td><code>rdfs:Literal</code></td>
      <td><em>testing</em></td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Resource language</td>
      <td><code>dct:language</code></td>
      <td><code>dct:LinguisticSystem</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td rowspan="2" colspan="2">Keyword</td>
      <td><code>dcat:theme</code></td>
      <td><code>skos:Concept</code></td>
      <td>stable</td>
      <td>For keywords from controlled vocabularies (as the INSPIRE spatial data themes and GEMET)</td>
    </tr>
    <tr>
      <td><code>dcat:keyword</code></td>
      <td><code>rdfs:Literal</code></td>
      <td>stable</td>
      <td>For free text keywords</td>
    </tr>
    <tr>
      <td colspan="2">Topic category</td>
      <td><code>dct:subject</code></td>
      <td><code>skos:Concept</code></td>
      <td><strong>unstable</strong></td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Maintenance frequency (Maintenance information)</td>
      <td><code>dct:accrualPeriodicity</code></td>
      <td><code>rdfs:Resource</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Lineage</td>
      <td><code>dct:provenance</code></td>
      <td><code>dct:ProvenanceStatement</code></td>
      <td>stable</td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Coordinate reference system</td>
      <td><strong><code>dct:conformsTo</code></strong></td>
      <td><strong><code>rdfs:Resource</code></strong></td>
      <td><strong>unstable</strong></td>
      <td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>
    </tr>
    <tr>
      <td colspan="2">Temporal reference system</td>
      <td><strong><code>dct:conformsTo</code></strong></td>
      <td><strong><code>rdfs:Resource</code></strong></td>
      <td><strong>unstable</strong></td>
      <td>Only for the extended profile. To be replaced with an appropriate mapping to a standard vocabulary, when available</td>
    </tr>
    <tr>
      <td colspan="2">* Spatial representation type</td>
      <td><strong><code>adms:representationTechnique</code></strong></td>
      <td><strong><code>rdfs:Resource</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile. The domain is <code>dcat:Distribution</code></td>
    </tr>
    <tr>
      <td colspan="2">* Format / Encoding</td>
      <td><code>dcat:mediaType</code></td>
      <td><code>dct:MediaTypeOrExtent</code></td>
      <td><em>testing</em></td>
      <td>The domain is <code>dcat:Distribution</code></td>
    </tr>
    <tr>
      <td colspan="2">* Character encoding</td>
      <td><strong><code>cnt:characterEncoding</code></strong></td>
      <td><strong><code>rdfs:Literal</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile. The domain is <code>dcat:Distribution</code></td>
    </tr>
<!--    
    <tr>
      <td>* Data quality - Logical consistency - Topological consistency</td>
      <td><em>no candidate available</em></td>
      <td><em>no candidate available</em></td>
      <td>pending</td>
      <td></td>
    </tr>
-->    
  </tbody>
</table>

<h3><a name="md-specific-service">Resource metadata specific to services</a></h3>
<p>The domain of the mappings is <code>dcat:Catalog</code> for catalogue / discovery service, and <code>dctype:Service</code> for all the other services.</p>

<table>
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
      <td><em>Any function</em></td>
      <td><code>foaf:homepage</code></td>
      <td><code>foaf:Document</code></td>
      <td><em>testing</em></td>
      <td></td>
    </tr>
    <tr>
      <td colspan="2">Coupled resource</td>
      <td><strong><code>dct:hasPart</code></strong></td>
      <td><strong><code>dcat:Dataset</code></strong></td>
      <td>stable</td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2">Spatial data service type</td>
      <td><strong><code>dct:type</code></strong></td>
      <td><strong><code>skos:Concept</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile</td>
    </tr>
    <tr>
      <td colspan="2" rowspan="3">Keyword</td>
      <td><strong><code>dct:type</code></strong></td>
      <td><strong><code>skos:Concept</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile. For spatial data service categories defined in ISO 19119</td>
    </tr>
    <tr>
      <td><strong><code>dct:subject</code></strong></td>
      <td><strong><code>skos:Concept</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile. For keywords from controlled vocabularies (as the INSPIRE spatial data themes and GEMET)</td>
    </tr>
    <tr>
      <td><strong><code>dc:subject</code></strong></td>
      <td><strong><code>rdfs:Literal</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile. For free text keywords</td>
    </tr>
    <tr>
      <td colspan="2">Spatial data service category</td>
      <td><strong><code>dct:type</code></strong></td>
      <td><strong><code>skos:Concept</code></strong></td>
      <td><em>testing</em></td>
      <td>Only for the extended profile</td>
    </tr>
  </tbody>
</table>

<h2><a name="mapping-individual">Mappings of individual metadata elements</a></h2>

This section illustrates with examples specific metadata elements whose mappings are not completely described in the <a href="#mapping-summary">mapping summary</a>.

<h3><a name="mapping-geo-id">Geographic identifier</a></h3>

If specified with an HTTP URI:

````xml
  <dct:spatial rdf:resource="http://publications.europa.eu/resource/authority/continent/EUROPE"/>
````

If specified with a literal:

````xml
  <dct:spatial rdf:parseType="Resource">
<!-- Code -->
    <skos:prefLabel xml:lang="en">Location &gt; Continent &gt; Europe</skos:prefLabel>
    <skos:inScheme>
<!-- Authority -->
      <skos:ConceptScheme>
        <rdfs:label xml:lang="en">NASA/GCMD Location Keywords</rdfs:label>
        <dct:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2009-01-01</dct:modified>
      </skos:ConceptScheme>
    </skos:inScheme>
  </dct:spatial>
````


<h3><a name="mapping-bbox">Geographic bounding box</a></h3>

The XSLT outputs a geographic bounding box in multiple encodings, namely, the ones recommended in GeoDCAT-AP (i.e., WKT and GML), and GeoJSON.

To denote the datatype of the GeoJSON literal, [the URL of the relevant IANA Media Type](https://www.iana.org/assignments/media-types/application/vnd.geo+json) is used.

````xml
  <dct:spatial rdf:parseType="Resource">
<!-- As WKT -->
    <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#wktLiteral"><![CDATA[POLYGON((-6.41736 55.7447,2.05827 55.7447,2.05827 49.8625,-6.41736 49.8625,-6.41736 55.7447))]]></locn:geometry>
<!- As GML -->
    <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#gmlLiteral"><![CDATA[<gml:Envelope srsName="http://www.opengis.net/def/crs/OGC/1.3/CRS84"><gml:lowerCorner>-6.41736 49.8625</gml:lowerCorner><gml:upperCorner>2.05827 55.7447</gml:upperCorner></gml:Envelope>]]></locn:geometry>
<!-- As GeoJSON -->
    <locn:geometry rdf:datatype="https://www.iana.org/assignments/media-types/application/vnd.geo+json"><![CDATA[{"type":"Polygon","crs":{"type":"name","properties":{"name":"urn:ogc:def:crs:OGC:1.3:CRS84"}},"coordinates":[[[-6.41736,55.7447],[2.05827,55.7447],[2.05827,49.8625],[-6.41736,49.8625],[-6.41736,55.7447]]]}]]></locn:geometry>
  </dct:spatial
````

<h3><a name="mapping-conformance-result">Conformance result / Conformity (Data quality)</a></h3>

GeoDCAT-AP provides only a partial mapping for data quality information, limited to the component "conformance result".

````xml
  <prov:wasUsedBy>
    <prov:Activity>
      <prov:qualifiedAssociation rdf:parseType="Resource">
        <prov:hadPlan rdf:parseType="Resource">
          <prov:wasDerivedFrom>
<!-- Specification -->
            <rdf:Description rdf:about="http://eur-lex.europa.eu/LexUriServ/LexUriServ.do?uri=CELEX:32010R1089:EN:NOT">
              <dct:title xml:lang="en">COMMISSION REGULATION (EU) No 1089/2010 of 23 November 2010 implementing Directive 2007/2/EC of the European Parliament and of the Council as regards interoperability of spatial data sets and services</dct:title>
              <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2010-12-08</dct:issued>
            </rdf:Description>
          </prov:wasDerivedFrom>
        </prov:hadPlan>
      </prov:qualifiedAssociation>
<!-- Conformance result / conformity degree -->      
      <prov:generated rdf:parseType="Resource">
        <dct:type rdf:resource="http://inspire.ec.europa.eu/metadata-codelist/DegreeOfConformity/notEvaluated"/>
        <dct:description xml:lang="en">See the referenced specification</dct:description>
      </prov:generated>
    </prov:Activity>
  </prov:wasUsedBy>
````

<h3><a name="mapping-responsible party">Responsible party</h3>


````xml
  <dcat:contactPoint>
    <vcard:Kind>
      <vcard:organization-name xml:lang="en">European Commission, Joint Research Centre</vcard:organization-name>
      <vcard:hasEmail rdf:resource="mailto:efdac@jrc.ec.europa.eu"/>
    </vcard:Kind>
  </dcat:contactPoint>
````


````xml
  <prov:qualifiedAttribution>
    <prov:Attribution>
      <prov:agent>
<!-- Responsible organisation -->
        <vcard:Kind>
          <vcard:organization-name xml:lang="en">European Commission, Joint Research Centre</vcard:organization-name>
          <vcard:hasEmail rdf:resource="mailto:efdac@jrc.ec.europa.eu"/>
        </vcard:Kind>
      </prov:agent>
<!-- Responsible party role -->
      <dct:type rdf:resource="http://inspire.ec.europa.eu/metadata-codelist/ResponsiblePartyRole/pointOfContact"/>
    </prov:Attribution>
  </prov:qualifiedAttribution>
````

