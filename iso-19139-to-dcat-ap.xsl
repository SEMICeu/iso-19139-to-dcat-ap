<?xml version="1.0" encoding="UTF-8"?>

<!--  

  Copyright 2015 EUROPEAN UNION
  Licensed under the EUPL, Version 1.1 or - as soon they will be approved by
  the European Commission - subsequent versions of the EUPL (the "Licence");
  You may not use this work except in compliance with the Licence.
  You may obtain a copy of the Licence at:
 
  http://ec.europa.eu/idabc/eupl
 
  Unless required by applicable law or agreed to in writing, software
  distributed under the Licence is distributed on an "AS IS" basis,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the Licence for the specific language governing permissions and
  limitations under the Licence.
 
  Authors: European Commission - Joint Research Centre
           Andrea Perego <andrea.perego@jrc.ec.europa.eu>
 
  This work was supported by the EU Interoperability Solutions for
  European Public Administrations Programme (http://ec.europa.eu/isa)
  through Action 1.17: Re-usable INSPIRE Reference Platform 
  (http://ec.europa.eu/isa/actions/01-trusted-information-exchange/1-17action_en.htm).

-->

<!--

  PURPOSE AND USAGE

  This XSLT is a proof of concept for the implementation of the suite of 
  specifications concerning the INSPIRE profile of DCAT-AP (INSPIRE+DCAT-AP), 
  available in the collaboration space of the INSPIRE Maintenance and 
  Implementation Group (MIG):
  
    https://ies-svn.jrc.ec.europa.eu/projects/metadata/wiki/Alignment_of_INSPIRE_metadata_with_DCAT-AP
    
  As such, this XSLT must be considered as unstable, and can be updated any 
  time based on the revisions to the INSPIRE+DCAT-AP specifications and 
  related work in the framework of INSPIRE and the EU ISA Programme, in 
  particular with respect to the work concerning the definition of a 
  geospatial extension to DCAT-AP (GeoDCAT-AP):
  
    https://joinup.ec.europa.eu/node/139283/
  
-->

<xsl:transform
    xmlns:xsl    = "http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf    = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs   = "http://www.w3.org/2000/01/rdf-schema#"
    xmlns:owl    = "http://www.w3.org/2002/07/owl#"
    xmlns:skos   = "http://www.w3.org/2004/02/skos/core#"
    xmlns:cnt    = "http://www.w3.org/2011/content#"
    xmlns:dc     = "http://purl.org/dc/elements/1.1/" 
    xmlns:dct    = "http://purl.org/dc/terms/"
    xmlns:dctype = "http://purl.org/dc/dcmitype/"
    xmlns:dcam   = "http://purl.org/dc/dcam/"
    xmlns:time   = "http://www.w3.org/2006/time#"
    xmlns:earl   = "http://www.w3.org/ns/earl#"
    xmlns:dcat   = "http://www.w3.org/ns/dcat#"
    xmlns:foaf   = "http://xmlns.com/foaf/0.1/"
    xmlns:wdrs   = "http://www.w3.org/2007/05/powder-s#"
    xmlns:prov   = "http://www.w3.org/ns/prov#"
    xmlns:vcard  = "http://www.w3.org/2006/vcard/ns#"
    xmlns:gsp    = "http://www.opengis.net/ont/geosparql#"
    xmlns:ecodp  = "http://ec.europa.eu/open-data/ontologies/ec-odp#"
    xmlns:locn   = "http://www.w3.org/ns/locn#"
    xmlns:gmd    = "http://www.isotc211.org/2005/gmd" 
    xmlns:gmx    = "http://www.isotc211.org/2005/gmx" 
    xmlns:gco    = "http://www.isotc211.org/2005/gco" 
    xmlns:srv    = "http://www.isotc211.org/2005/srv"
    xmlns:xsi    = "http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:gml    = "http://www.opengis.net/gml" 
    xmlns:xlink  = "http://www.w3.org/1999/xlink" 
    xmlns:ns9    = "http://inspire.ec.europa.eu/schemas/geoportal/1.0"
    xmlns:i      = "http://inspire.ec.europa.eu/schemas/common/1.0"
    xmlns:schema = "http://schema.org/"
    version="1.0">

  <xsl:output method="xml"
              indent="yes"
              encoding="utf-8"
              cdata-section-elements="locn:geometry" />

<!--

  Mapping parameters
  ==================
  
  This section includes mapping parameters to be modified manually. 

-->

<!-- Parameter $profile -->
<!--

  This parameter specifies the INSPIRE+DCAT-AP profile to be used:
  - value "core": the INSPIRE+DCAT-AP Core profile, which includes only the INSPIRE metadata elements supported in
    DCAT-AP
  - value "extended": the INSPIRE+DCAT-AP Extended profile, which defines mappings for all the INSPIRE metadata elements
  
  The current specifications for the core and extended INSPIRE+DCAT-AP profiles are available in the collaboration 
  space of the INSPIRE MIG:
  - INSPIRE+DCAT-AP Core:
    https://ies-svn.jrc.ec.europa.eu/projects/metadata/wiki/INSPIRE_profile_of_DCAT-AP_-_Core_version
  - INSPIRE+DCAT-AP Extended:
    https://ies-svn.jrc.ec.europa.eu/projects/metadata/wiki/INSPIRE_profile_of_DCAT-AP_-_Extended_version   

-->

<!-- Uncomment to use INSPIRE+DCAT-AP Core -->
  <xsl:param name="profile">extended</xsl:param>
<!-- Uncomment to use INSPIRE+DCAT-AP Extended -->
<!--
  <xsl:param name="profile">extended</xsl:param>
-->

<!--

  Other global parameters
  =======================
  
-->  
  
<!-- Namespaces -->

  <xsl:param name="xsd">http://www.w3.org/2001/XMLSchema#</xsl:param>
  <xsl:param name="dct">http://purl.org/dc/terms/</xsl:param>
  <xsl:param name="dctype">http://purl.org/dc/dcmitype/</xsl:param>
  <xsl:param name="timeUri">http://placetime.com/</xsl:param>
  <xsl:param name="timeInstantUri" select="concat($timeUri,'instant/gregorian/')"/>
  <xsl:param name="timeIntervalUri" select="concat($timeUri,'interval/gregorian/')"/>
  <xsl:param name="dcat">http://www.w3.org/ns/dcat#</xsl:param>
  <xsl:param name="gsp">http://www.opengis.net/ont/geosparql#</xsl:param>
  <xsl:param name="ogcCrsBaseUri">http://www.opengis.net/def/EPSG/0/</xsl:param>
  <xsl:param name="ogcCrsBaseUrn">urn:ogc:def:EPSG::</xsl:param>
  <xsl:param name="inspire">http://inspire.ec.europa.eu/schemas/md/</xsl:param>
  <xsl:param name="kos">http://ec.europa.eu/open-data/kos/</xsl:param>
  <xsl:param name="kosil" select="concat($kos,'interoperability-level/')"/>
  <xsl:param name="kosdst" select="concat($kos,'dataset-type/')"/>
  <xsl:param name="kosdss" select="concat($kos,'dataset-status/Completed')"/>
  <xsl:param name="kosdoct" select="concat($kos,'documentation-type/')"/>
  <xsl:param name="koslic" select="concat($kos,'licence/EuropeanCommission')"/>
  <xsl:param name="op">http://publications.europa.eu/resource/authority/</xsl:param>
  <xsl:param name="opcountry" select="concat($op,'country/')"/>
  <xsl:param name="oplang" select="concat($op,'language/')"/>
  <xsl:param name="opcb" select="concat($op,'corporate-body/')"/>
  <xsl:param name="cldFrequency">http://purl.org/cld/freq/"</xsl:param>

  <xsl:param name="geojsonMediaTypeUri">https://www.iana.org/assignments/media-types/application/vnd.geo+json</xsl:param>

<!-- INSPIRE code list URIs -->  
  
  <xsl:param name="INSPIRECodelistUri">http://inspire.ec.europa.eu/metadata-codelist/</xsl:param>
  <xsl:param name="SpatialDataServiceCategoryCodelistUri" select="concat($INSPIRECodelistUri,'SpatialDataServiceCategory')"/>
  <xsl:param name="DegreeOfConformityCodelistUri" select="concat($INSPIRECodelistUri,'DegreeOfConformity')"/>
  <xsl:param name="ResourceTypeCodelistUri" select="concat($INSPIRECodelistUri,'ResourceType')"/>
  <xsl:param name="ResponsiblePartyRoleCodelistUri" select="concat($INSPIRECodelistUri,'ResponsiblePartyRole')"/>
  <xsl:param name="SpatialDataServiceTypeCodelistUri" select="concat($INSPIRECodelistUri,'SpatialDataServiceType')"/>
  <xsl:param name="TopicCategoryCodelistUri" select="concat($INSPIRECodelistUri,'TopicCategory')"/>

<!-- EPSG SRID for spatial reference system -->

  <xsl:param name="srid">4326</xsl:param>
    
<!-- 

  Master template     
  ===============
 
 -->
 
  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates select="gmd:MD_Metadata|//gmd:MD_Metadata"/>
    </rdf:RDF>
  </xsl:template>

<!-- 

  Metadata template     
  =================
 
 -->
  
  <xsl:template match="gmd:MD_Metadata|//gmd:MD_Metadata">

<!-- 

  Parameters to create HTTP URIs for the resource and the corresponding metadata record 
  =====================================================================================

  These parameters must be customised depending on the strategy used to assign HTTP URIs.

-->  

  <xsl:param name="ResourceUri"/>
  <xsl:param name="MetadataUri"/>

<!-- 

  Other parameters 
  ================
  
-->  
  
<!-- Metadata language: corresponding Alpha-2 codes -->
  
    <xsl:param name="ormlang">
      <xsl:value-of select="gmd:language/gmd:LanguageCode/@codeListValue"/>
    </xsl:param>
    
    <xsl:param name="MetadataLanguage">
      <xsl:choose>
        <xsl:when test="$ormlang = 'bul'">
          <xsl:text>bg</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'cze'">
          <xsl:text>cs</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'dan'">
          <xsl:text>da</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'ger'">  
          <xsl:text>de</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'gre'">
          <xsl:text>el</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'eng'">
          <xsl:text>en</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'spa'">
          <xsl:text>es</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'est'">
          <xsl:text>et</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'fin'">
          <xsl:text>fi</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'fre'">
          <xsl:text>fr</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'gle'">
          <xsl:text>ga</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'ita'">
          <xsl:text>it</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'lav'">
          <xsl:text>lv</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'lit'">
          <xsl:text>lt</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'hun'">
          <xsl:text>hu</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'mlt'">
          <xsl:text>mt</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'dut'">
          <xsl:text>nl</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'pol'">
          <xsl:text>pl</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'por'">
          <xsl:text>pt</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'rum'">
          <xsl:text>ru</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'slo'">
          <xsl:text>sk</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'slv'">
          <xsl:text>sl</xsl:text>
        </xsl:when>
        <xsl:when test="$ormlang = 'swe'">
          <xsl:text>sv</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$ormlang"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>

<!-- Resource language: corresponding Alpha-2 codes -->

    <xsl:param name="orrlang">
      <xsl:value-of select="gmd:identificationInfo/*/gmd:language/gmd:LanguageCode/@codeListValue"/>
    </xsl:param>
    <xsl:param name="ResourceLanguage">
      <xsl:choose>
        <xsl:when test="$orrlang = 'bul'">
          <xsl:text>bg</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'cze'">
          <xsl:text>cs</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'dan'">
          <xsl:text>da</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'ger'">  
          <xsl:text>de</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'gre'">
          <xsl:text>el</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'eng'">
          <xsl:text>en</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'spa'">
          <xsl:text>es</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'est'">
          <xsl:text>et</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'fin'">
          <xsl:text>fi</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'fre'">
          <xsl:text>fr</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'gle'">
          <xsl:text>ga</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'ita'">
          <xsl:text>it</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'lav'">
          <xsl:text>lv</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'lit'">
          <xsl:text>lt</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'hun'">
          <xsl:text>hu</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'mlt'">
          <xsl:text>mt</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'dut'">
          <xsl:text>nl</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'pol'">
          <xsl:text>pl</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'por'">
          <xsl:text>pt</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'rum'">
          <xsl:text>ru</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'slo'">
          <xsl:text>sk</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'slv'">
          <xsl:text>sl</xsl:text>
        </xsl:when>
        <xsl:when test="$orrlang = 'swe'">
          <xsl:text>sv</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$orrlang"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>

    <xsl:param name="ResourceType">
      <xsl:value-of select="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue"/>
    </xsl:param>
    
    <xsl:param name="ResourceTitle">
      <xsl:value-of select="gmd:identificationInfo[1]/*/gmd:citation/*/gmd:title/gco:CharacterString"/>
    </xsl:param>

    <xsl:param name="ResourceAbstract">
      <xsl:value-of select="gmd:identificationInfo[1]/*/gmd:abstract/gco:CharacterString"/>
    </xsl:param>

    <xsl:param name="Lineage">
      <xsl:value-of select="gmd:dataQualityInfo/*/gmd:lineage/*/gmd:statement/gco:CharacterString"/>
    </xsl:param>

    <xsl:param name="MetadataDate">
      <xsl:choose>
        <xsl:when test="gmd:dateStamp/gco:Date">
          <xsl:value-of select="gmd:dateStamp/gco:Date"/>
        </xsl:when>
        <xsl:when test="gmd:dateStamp/gco:DateTime">
          <xsl:value-of select="substring(gmd:dateStamp/gco:DateTime/text(),1,10)"/>
        </xsl:when>
      </xsl:choose>
    </xsl:param>

    <xsl:param name="UniqueResourceIdentifier">
      <xsl:for-each select="gmd:identificationInfo[1]/*/gmd:citation/*/gmd:identifier/gmd:RS_Identifier">
        <xsl:choose>
          <xsl:when test="gmd:codeSpace/gco:CharacterString/text() != ''">
            <xsl:value-of select="concat(translate(gmd:codeSpace/gco:CharacterString/text(),' ','%20'),translate(gmd:code/gco:CharacterString/text(),' ','%20'))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="translate(gmd:code/gco:CharacterString/text(),' ','%20')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:param>

    <xsl:param name="ConstraintsRelatedToAccessAndUse">
      <xsl:apply-templates select="gmd:identificationInfo[1]/*/gmd:resourceConstraints/*">
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
    </xsl:param>
    
<!-- Conformity, expressed by using an earl:Assertion (only for the extended profile) -->    
    
    <xsl:param name="Conformity">
      <xsl:for-each select="gmd:dataQualityInfo/*/gmd:report/*/gmd:result/*/gmd:specification/gmd:CI_Citation">
    <xsl:variable name="specinfo">
      <dct:title xml:lang="{$MetadataLanguage}">
        <xsl:value-of select="gmd:title/gco:CharacterString"/>
      </dct:title>
      <xsl:apply-templates select="gmd:date/gmd:CI_Date"/>
    </xsl:variable>
    <xsl:variable name="degree">
      <xsl:choose>
        <xsl:when test="../../gmd:pass = 'true'">
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/conformant')"/>
        </xsl:when>
        <xsl:when test="../../gmd:pass = 'false'">
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/notConformant')"/>
        </xsl:when>
        <xsl:otherwise>
<!--        
        <xsl:when test="../../gmd:pass = ''">
-->        
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/notEvaluated')"/>
<!--          
        </xsl:when>
-->        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
        <earl:Assertion>
          <xsl:if test="$ResourceUri != ''">
            <earl:subject rdf:resource="{$ResourceUri}"/>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="../@xlink:href and ../@xlink:href != ''">
              <earl:test>
                <rdf:Description rdf:about="{../@xlink:href}">
                  <xsl:copy-of select="$specinfo"/>
                </rdf:Description>
              </earl:test>
            </xsl:when>
            <xsl:otherwise>
              <earl:test rdf:parseType="Resource">
                <xsl:copy-of select="$specinfo"/>
              </earl:test>
            </xsl:otherwise>
          </xsl:choose>
          <earl:result>
            <earl:TestResult>
              <earl:outcome rdf:resource="{$degree}"/>
            </earl:TestResult>
          </earl:result>
        </earl:Assertion>
      </xsl:for-each>
    </xsl:param>
    
    <xsl:param name="ResourceCharacterEncoding">
      <xsl:for-each select="gmd:identificationInfo/gmd:MD_DataIdentification">
        <xsl:apply-templates select="gmd:characterSet/gmd:MD_CharacterSetCode"/>
      </xsl:for-each>  
    </xsl:param>
    
    
    <xsl:param name="MetadataDescription">
<!-- Metadata language -->
      <dct:language rdf:resource="{concat($oplang,translate($ormlang,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'))}"/>
<!-- Metadata date -->
      <dct:modified rdf:datatype="{$xsd}date">
        <xsl:value-of select="$MetadataDate"/>
      </dct:modified>
<!-- Metadata point of contact -->
      <xsl:apply-templates select="gmd:contact/gmd:CI_ResponsibleParty">
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
<!-- Metadata file identifier (proposal) -->
      <xsl:for-each select="gmd:fileIdentifier/gco:CharacterString">
        <dct:identifier rdf:datatype="{$xsd}string"><xsl:value-of select="."/></dct:identifier>
      </xsl:for-each>  
<!-- Metadata standard (proposal) -->
      <xsl:for-each select="gmd:metadataStandardName/gco:CharacterString">
        <xsl:if test="text() != '' or ../../gmd:metadataStandardVersion/gco:CharacterString/text() != ''">
          <dct:source rdf:parseType="Resource">
            <dct:conformsTo>
              <xsl:if test="text() != ''">
<!-- Metadata standard name -->              
                <dct:title xml:lang="{$MetadataLanguage}"><xsl:value-of select="."/></dct:title>
              </xsl:if>
              <xsl:if test="../../gmd:metadataStandardName/gco:CharacterString/text() != ''">
<!-- Metadata standard version -->              
                <owl:versionInfo xml:lang="{$MetadataLanguage}"><xsl:value-of select="../../gmd:metadataStandardVersion/gco:CharacterString"/></owl:versionInfo>
              </xsl:if>
            </dct:conformsTo>    
          </dct:source>
        </xsl:if>
      </xsl:for-each>
    </xsl:param>  

    <xsl:param name="ResourceDescription">
      <xsl:choose>
        <xsl:when test="$ResourceType = 'dataset'">
          <rdf:type rdf:resource="{$dcat}Dataset"/>
        </xsl:when>
        <xsl:when test="$ResourceType = 'series'">
          <rdf:type rdf:resource="{$dcat}Dataset"/>
        </xsl:when>
        <xsl:when test="$ResourceType = 'service'">
          <rdf:type rdf:resource="{$dcat}Catalog"/>
        </xsl:when>
      </xsl:choose>
      <xsl:if test="$profile = 'extended'">
        <dct:type rdf:resource="{$ResourceTypeCodelistUri}/{$ResourceType}"/>
      </xsl:if>
      <dct:title xml:lang="{$MetadataLanguage}"><xsl:value-of select="$ResourceTitle"/></dct:title>
      <dct:description xml:lang="{$MetadataLanguage}">
        <xsl:value-of select="normalize-space($ResourceAbstract)"/>
      </dct:description>
<!-- Maintenance information (proposal) -->
      <xsl:for-each select="gmd:identificationInfo/*/gmd:resourceMaintenance">
        <xsl:apply-templates select="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode"/>      
      </xsl:for-each>
<!-- Topic category -->
      <xsl:if test="$profile = 'extended'">
        <xsl:apply-templates select="gmd:identificationInfo/*/gmd:topicCategory">
          <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
        </xsl:apply-templates>
      </xsl:if>
<!-- Keyword -->
      <xsl:apply-templates select="gmd:identificationInfo/*/gmd:descriptiveKeywords/gmd:MD_Keywords">
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
<!-- Identifier, 0..1 -->
<!--        
      <xsl:apply-templates select="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier">
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
-->        
<!-- Resource locators -->
<!--
      <xsl:apply-templates select="gmd:distributionInfo/*/gmd:transferOptions/*/gmd:onLine/*/gmd:linkage">
        <xsl:with-param name="ResourceType" select="$ResourceType"/>
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
-->      
<!-- Unique Resource Identifier -->
      <xsl:apply-templates select="gmd:identificationInfo/*/gmd:citation/*/gmd:identifier/gmd:RS_Identifier"/>
<!-- Coupled resources -->
      <xsl:apply-templates select="gmd:identificationInfo[1]/*/srv:operatesOn">
        <xsl:with-param name="ResourceType" select="$ResourceType"/>
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
<!-- Resource Language -->        
      <dct:language rdf:resource="{concat($oplang,translate($orrlang,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'))}"/>
<!-- Spatial service type -->
      <xsl:if test="$profile = 'extended'">
        <xsl:apply-templates select="gmd:identificationInfo/*/srv:serviceType">
          <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
        </xsl:apply-templates>
      </xsl:if>
<!-- Spatial extent -->
      <xsl:apply-templates select="gmd:identificationInfo[1]/*/*[self::gmd:extent|self::srv:extent]/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox"/>
<!-- Temporal extent -->
      <xsl:apply-templates select="gmd:identificationInfo/*/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent"/>
<!-- Creation date, publication date, date of last revision -->
      <xsl:apply-templates select="gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation"/>
<!-- Lineage -->
      <xsl:if test="$ResourceType != 'service' and $profile = 'extended'">
        <dct:provenance>
          <dct:ProvenanceStatement>
            <rdfs:label xml:lang="{$MetadataLanguage}">
              <xsl:value-of select="normalize-space($Lineage)"/>
            </rdfs:label>
          </dct:ProvenanceStatement>
        </dct:provenance>
      </xsl:if>
<!-- Spatial resolution -->
      <xsl:if test="$profile = 'extended'">
        <xsl:apply-templates select="gmd:identificationInfo/*/gmd:spatialResolution/gmd:MD_Resolution"/>
      </xsl:if>
<!-- Conformity -->
      <xsl:apply-templates select="gmd:dataQualityInfo/*/gmd:report/*/gmd:result/*/gmd:specification/gmd:CI_Citation">
        <xsl:with-param name="ResourceUri" select="$ResourceUri"/>
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
        <xsl:with-param name="Conformity" select="$Conformity"/>
      </xsl:apply-templates>
<!-- Distributions -->
      <xsl:for-each select="gmd:distributionInfo/gmd:MD_Distribution">
        <dcat:distribution>
          <dcat:Distribution>
<!-- Resource locators (access / download URLs) -->          
            <xsl:apply-templates select="gmd:transferOptions/*/gmd:onLine/*/gmd:linkage">
              <xsl:with-param name="ResourceType" select="$ResourceType"/>
              <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
            </xsl:apply-templates>
<!-- Constraints related to access and use -->
            <xsl:copy-of select="$ConstraintsRelatedToAccessAndUse"/>
<!-- Encoding -->      
            <xsl:apply-templates select="gmd:distributionFormat/gmd:MD_Format/gmd:name/gco:CharacterString"/>
<!-- Resource character encoding -->
            <xsl:if test="$profile = 'extended'">
              <xsl:copy-of select="$ResourceCharacterEncoding"/>
            </xsl:if>
          </dcat:Distribution>
        </dcat:distribution>
      </xsl:for-each>    
<!-- Responsible organisation -->
      <xsl:apply-templates select="gmd:identificationInfo/*/gmd:pointOfContact/gmd:CI_ResponsibleParty">
        <xsl:with-param name="MetadataLanguage" select="$MetadataLanguage"/>
      </xsl:apply-templates>
    </xsl:param>

    <xsl:choose>
      <xsl:when test="$ResourceUri != ''">
        <xsl:if test="$profile = 'extended'">
          <xsl:choose>
            <xsl:when test="$MetadataUri != ''">
              <rdf:Description rdf:about="{$MetadataUri}">
                <foaf:primaryTopic rdf:resource="{$ResourceUri}"/>
                <xsl:copy-of select="$MetadataDescription"/>
              </rdf:Description>
            </xsl:when>
            <xsl:otherwise>
              <rdf:Description>
                <foaf:primaryTopic rdf:resource="{$ResourceUri}"/>
                <xsl:copy-of select="$MetadataDescription"/>
              </rdf:Description>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <rdf:Description rdf:about="{$ResourceUri}">
          <xsl:copy-of select="$ResourceDescription"/>
        </rdf:Description>
      </xsl:when>
      <xsl:otherwise>
        <rdf:Description>
          <xsl:if test="$profile = 'extended'">
            <foaf:isPrimaryTopicOf>
              <rdf:Description>
                <xsl:copy-of select="$MetadataDescription"/>
              </rdf:Description>
            </foaf:isPrimaryTopicOf>
          </xsl:if>
          <xsl:copy-of select="$ResourceDescription"/>
        </rdf:Description>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="$profile = 'extended' and $ResourceUri != '' and $Conformity != ''">
      <xsl:copy-of select="$Conformity"/>
    </xsl:if>
    
      
  </xsl:template>
  
<!--

  Templates for specific metadata elements
  ========================================

-->  
  
<!-- Unique Resource Identifier -->  
  
  <xsl:template name="UniqueResourceIdentifier" match="gmd:identificationInfo/*/gmd:citation/*/gmd:identifier/gmd:RS_Identifier">
    <xsl:param name="ns">
      <xsl:value-of select="gmd:codeSpace/gco:CharacterString"/>
    </xsl:param>
    <xsl:param name="code">
      <xsl:value-of select="gmd:code/gco:CharacterString"/>
    </xsl:param>
    <xsl:param name="id">
      <xsl:choose>
        <xsl:when test="$ns != ''">
          <xsl:value-of select="concat(translate($ns,' ','%20'),'/',translate($code,' ','%20'))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate($code,' ','%20')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <dct:identifier rdf:datatype="{$xsd}string"><xsl:value-of select="$id"/></dct:identifier>
  </xsl:template>

<!-- Responsible Organisation -->      

  <xsl:template name="ResponsibleOrganisation" match="gmd:identificationInfo/*/gmd:pointOfContact/gmd:CI_ResponsibleParty">
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="role">
<!-- ISSUE The same problem we have for ResourceLocator function: the RDSI editor saves the relevant code as the text node of the relevant element, instead of using the correct attribute (@codeListValue) -->
      <xsl:value-of select="gmd:role/gmd:CI_RoleCode/@codeListValue"/>
    </xsl:param>
    <xsl:param name="ResponsiblePartyRole">
      <xsl:value-of select="concat($ResponsiblePartyRoleCodelistUri,'/',$role)"/>
    </xsl:param>
    <xsl:param name="OrganisationName">
      <xsl:value-of select="gmd:organisationName/gco:CharacterString"/>
    </xsl:param>
    <xsl:param name="ROInfo">
      <foaf:Organization>
        <foaf:name xml:lang="{$MetadataLanguage}">
          <xsl:value-of select="$OrganisationName"/>
        </foaf:name>
        <xsl:for-each select="gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
          <foaf:mbox rdf:resource="mailto:{.}"/>
        </xsl:for-each>
      </foaf:Organization>
    </xsl:param>
    <xsl:param name="ResponsibleParty">
      <vcard:Kind>
        <vcard:organization-name xml:lang="{$MetadataLanguage}">
          <xsl:value-of select="$OrganisationName"/>
        </vcard:organization-name>
        <xsl:for-each select="gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
          <vcard:hasEmail rdf:resource="mailto:{.}"/>
        </xsl:for-each>
      </vcard:Kind>
    </xsl:param>
    <xsl:choose>
<!--   
      <xsl:when test="$role = 'resourceProvider'">
        <schema:provider>
          <xsl:copy-of select="$ROInfo"/>
        </schema:provider>
      </xsl:when>
-->      
<!--      
      <xsl:when test="$role = 'custodian'">
        <rdarole:custodian>
          <xsl:copy-of select="$ROInfo"/>
        </rdarole:custodian>
      </xsl:when>
-->      
      <xsl:when test="$role = 'owner' and $profile = 'extended'">
        <dct:rightsHolder>
          <xsl:copy-of select="$ROInfo"/>
        </dct:rightsHolder>
      </xsl:when>
<!--      
      <xsl:when test="$role = 'user'">
        <prov:wasUsedBy>
          <prov:Activity>
            <prov:wasAssociatedWith>
              <xsl:copy-of select="$ROInfo"/>
            </prov:wasAssociatedWith>
          </prov:Activity>
        </prov:wasUsedBy>
      </xsl:when>
-->
<!--        
      <xsl:when test="$role = 'distributor'">
        <rdarole:distributor>
          <xsl:copy-of select="$ROInfo"/>
        </rdarole:distributor>
      </xsl:when>
-->        
      <xsl:when test="$role = 'originator' and $profile = 'extended'">
        <dct:creator>
          <xsl:copy-of select="$ROInfo"/>
        </dct:creator>
      </xsl:when>
      <xsl:when test="$role = 'pointOfContact'">
        <dcat:contactPoint>
          <xsl:copy-of select="$ResponsibleParty"/>
        </dcat:contactPoint>
      </xsl:when>
<!--      
      <xsl:when test="$role = 'principalInvestigator'">
        <dct:contributor>
          <xsl:copy-of select="$ROInfo"/>
        </dct:contributor>
      </xsl:when>
-->      
<!--      
      <xsl:when test="$role = 'processor'">
        <prov:entityOfInfluence>
          <prov:Derivation>
            <prov:hadActivity>
              <prov:Activity>
                <prov:wasAssociatedWith>
                  <xsl:copy-of select="$ROInfo"/>
                </prov:wasAssociatedWith>
              </prov:Activity>
            </prov:hadActivity>
          </prov:Derivation>
        </prov:entityOfInfluence>
      </xsl:when>
-->      
      <xsl:when test="$role = 'publisher'">
        <dct:publisher>
          <xsl:copy-of select="$ROInfo"/>
        </dct:publisher>
      </xsl:when>
<!--      
      <xsl:when test="$role = 'author'">
        <rdarole:author>
          <xsl:copy-of select="$ROInfo"/>
        </rdarole:author>
      </xsl:when>
-->        
    </xsl:choose>
    <xsl:if test="$profile = 'extended'">
      <prov:qualifiedAttribution>
        <prov:Attribution>
          <prov:agent>
            <xsl:copy-of select="$ResponsibleParty"/>
          </prov:agent>
          <dct:type rdf:resource="{$ResponsiblePartyRole}"/>
        </prov:Attribution>
      </prov:qualifiedAttribution>
    </xsl:if>
  </xsl:template>

<!-- Metadata point of contact -->

  <xsl:template name="MetadataPointOfContact" match="gmd:contact/gmd:CI_ResponsibleParty">
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="ResponsiblePartyRole">
      <xsl:value-of select="concat($ResponsiblePartyRoleCodelistUri,'/','pointOfContact')"/>
    </xsl:param>
    <xsl:param name="OrganisationName">
      <xsl:value-of select="gmd:organisationName/gco:CharacterString"/>
    </xsl:param>
    <xsl:param name="ResponsibleParty">
      <vcard:Kind>
        <vcard:organization-name xml:lang="{$MetadataLanguage}">
          <xsl:value-of select="$OrganisationName"/>
        </vcard:organization-name>
        <xsl:for-each select="gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
          <vcard:hasEmail rdf:resource="mailto:{.}"/>
        </xsl:for-each>
      </vcard:Kind>
    </xsl:param>    
    <dcat:contactPoint>
      <xsl:copy-of select="$ResponsibleParty"/>
    </dcat:contactPoint>
    <prov:qualifiedAttribution>
      <prov:Attribution>
        <prov:agent>
          <xsl:copy-of select="$ResponsibleParty"/>
        </prov:agent>
        <dct:type rdf:resource="{$ResponsiblePartyRole}"/>
      </prov:Attribution>
    </prov:qualifiedAttribution>    
  </xsl:template>

<!-- Resource locator -->
<!-- Old version, applied to the resource (not to the resource distribution)
  <xsl:template name="ResourceLocator" match="gmd:distributionInfo/*/gmd:transferOptions/*/gmd:onLine/*/gmd:linkage">
    <xsl:param name="ResourceType"/>
    <xsl:choose>
      <xsl:when test="$ResourceType = 'dataset' or $ResourceType = 'series'">
        <dcat:landingPage rdf:resource="{gmd:URL}"/>
      </xsl:when>
      <xsl:when test="$ResourceType = 'service'">
        <foaf:homepage rdf:resource="{gmd:URL}"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
-->
  <xsl:template name="ResourceLocator" match="gmd:transferOptions/*/gmd:onLine/*/gmd:linkage">
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="ResourceType"/>
    <xsl:choose>
      <xsl:when test="$ResourceType = 'dataset' or $ResourceType = 'series'">
        <dct:title xml:lang="{$MetadataLanguage}"><xsl:value-of select="../gmd:description/gco:CharacterString"/></dct:title>
        <dcat:accessURL rdf:resource="{gmd:URL}"/>
     </xsl:when>
<!--      
      <xsl:when test="$ResourceType = 'service'">
        <foaf:homepage rdf:resource="{gmd:URL}"/>
      </xsl:when>
-->      
    </xsl:choose>
  </xsl:template>

<!-- Coupled resource -->

  <xsl:template name="CoupledResource" match="gmd:identificationInfo[1]/*/srv:operatesOn">
    <dcat:dataset rdf:resource="{@xlink:href}"/>
  </xsl:template>
  
<!-- Spatial data service type -->  
  
  <xsl:template match="gmd:identificationInfo/*/srv:serviceType">
    <dct:type rdf:resource="{$SpatialDataServiceTypeCodelistUri}/{gco:LocalName}"/>
  </xsl:template>
  
<!-- Conformity -->  
  <xsl:template name="Conformity" match="gmd:dataQualityInfo/*/gmd:report/*/gmd:result/*/gmd:specification/gmd:CI_Citation">
    <xsl:param name="ResourceUri"/>
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="Conformity"/>
    <xsl:variable name="specinfo">
      <dct:title xml:lang="{$MetadataLanguage}">
        <xsl:value-of select="gmd:title/gco:CharacterString"/>
      </dct:title>
      <xsl:apply-templates select="gmd:date/gmd:CI_Date"/>
    </xsl:variable>
    <xsl:variable name="degree">
      <xsl:choose>
        <xsl:when test="../../gmd:pass = 'true'">
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/conformant')"/>
        </xsl:when>
        <xsl:when test="../../gmd:pass = 'false'">
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/notConformant')"/>
        </xsl:when>
        <xsl:otherwise>
<!--        
        <xsl:when test="../../gmd:pass = ''">
-->        
          <xsl:value-of select="concat($DegreeOfConformityCodelistUri,'/notEvaluated')"/>
<!--          
        </xsl:when>
-->        
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="../../gmd:pass = 'true'">
      <xsl:choose>
        <xsl:when test="../@xlink:href and ../@xlink:href != ''">
          <dct:conformsTo>
            <rdf:Description rdf:about="{../@xlink:href}">
              <xsl:copy-of select="$specinfo"/>
            </rdf:Description>
          </dct:conformsTo>
        </xsl:when>
        <xsl:otherwise>
          <dct:conformsTo rdf:parseType="Resource">
            <xsl:copy-of select="$specinfo"/>
          </dct:conformsTo>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$profile = 'extended'">
      <xsl:if test="$Conformity != '' and $ResourceUri = ''">
        <wdrs:describedby>
          <xsl:copy-of select="$Conformity"/>
        </wdrs:describedby>
      </xsl:if>
<!--    
      <xsl:choose>
        <xsl:when test="../@xlink:href and ../@xlink:href != ''">
          <wdrs:describedby>
            <earl:Assertion>
              <earl:test>
                <rdf:Description rdf:about="{../@xlink:href}">
                  <xsl:copy-of select="$specinfo"/>
                </rdf:Description>
              </earl:test>
              <earl:result>
                <earl:TestResult>
                  <earl:outcome rdf:resource="{$degree}"/>
                </earl:TestResult>
              </earl:result>
            </earl:Assertion>
          </wdrs:describedby>
        </xsl:when>
        <xsl:otherwise>
          <wdrs:describedby>
            <earl:Assertion>
              <earl:test rdf:parseType="Resource">
                <xsl:copy-of select="$specinfo"/>
              </earl:test>
              <earl:result>
                <earl:TestResult>
                  <earl:outcome rdf:resource="{$degree}"/>
                </earl:TestResult>
              </earl:result>
            </earl:Assertion>
          </wdrs:describedby>
        </xsl:otherwise>
      </xsl:choose>
-->    
    </xsl:if>
  </xsl:template>
  
<!-- Geographic bounding box -->  

  <xsl:template name="GeographicBoundingBox" match="gmd:identificationInfo[1]/*/*[self::gmd:extent|self::srv:extent]/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox">
<!-- Need to check whether this is correct - in particular, the "projection" parameter -->
<!--    
    <xsl:param name="DCTBox">northlimit=<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>; eastlimit=<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>; southlimit=<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>; westlimit=<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>; projection=EPSG:<xsl:value-of select="$srid"/></xsl:param>
-->

<!-- Axis order: lon/lat. -->
<!--    
    <xsl:param name="GMLLiteral">&lt;gml:Envelope srsName="<xsl:value-of select="concat($ogcCrsBaseUri,$srid)"/>"&gt;&lt;gml:lowerCorner&gt;<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>&lt;/gml:lowerCorner&gt;&lt;gml:upperCorner&gt;<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>&lt;/gml:upperCorner&gt;&lt;/gml:Envelope&gt;</xsl:param>
    
    <xsl:param name="WKTLiteral">&lt;<xsl:value-of select="concat($ogcCrsBaseUri,$srid)"/>&gt; POLYGON((<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>,<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>,<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>,<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>,<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>))</xsl:param>

    <xsl:param name="GeoJSONLiteral">{"type":"Polygon","crs":{"type":"name","properties":{"name":"<xsl:value-of select="concat($ogcCrsBaseUrn,$srid)"/>"}},"coordinates":[[[<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>],[<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>],[<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>],[<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>],[<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>]]]}</xsl:param>
-->
<!-- Axis order (for, e.g., EPSG:4326): lat/long. -->

    <xsl:param name="GMLLiteral">&lt;gml:Envelope srsName="<xsl:value-of select="concat($ogcCrsBaseUri,$srid)"/>"&gt;&lt;gml:lowerCorner&gt;<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&lt;/gml:lowerCorner&gt;&lt;gml:upperCorner&gt;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>&lt;/gml:upperCorner&gt;&lt;/gml:Envelope&gt;</xsl:param>
    
    <xsl:param name="WKTLiteral">&lt;<xsl:value-of select="concat($ogcCrsBaseUri,$srid)"/>&gt; POLYGON((<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>,<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>,<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>,<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>,<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text> </xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>))</xsl:param>

    <xsl:param name="GeoJSONLiteral">{"type":"Polygon","crs":{"type":"name","properties":{"name":"<xsl:value-of select="concat($ogcCrsBaseUrn,$srid)"/>"}},"coordinates":[[[<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>],[<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>],[<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>],[<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>],[<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/><xsl:text>,</xsl:text><xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>]]]}</xsl:param>

<!--
    <dct:spatial>
      <rdf:value rdf:datatype="{$dct}Box"><xsl:value-of select="$DCTBox"/></rdf:value>
    </dct:spatial>
-->    
    <dct:spatial>
      <dct:Location>
        <locn:geometry rdf:datatype="{$gsp}gmlLiteral"><xsl:value-of select="$GMLLiteral"/></locn:geometry>
<!--        
        <locn:geometry rdf:datatype="{$gsp}wktLiteral"><xsl:value-of select="$WKTLiteral"/></locn:geometry>
        <locn:geometry rdf:datatype="{$geojsonMediaTypeUri}"><xsl:value-of select="$GeoJSONLiteral"/></locn:geometry>
-->        
      </dct:Location>
    </dct:spatial>
  </xsl:template>
  
<!-- Temporal extent -->  

  <xsl:template name="TemporalExtent" match="gmd:identificationInfo/*/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent">
    <xsl:for-each select="gmd:extent/gml:TimeInstant|gmd:extent/gml:TimePeriod">
      <xsl:if test="local-name(.) = 'TimeInstant' or ( local-name(.) = 'TimePeriod' and gml:beginPosition and gml:endPosition )">
<!--      
        <xsl:variable name="dctperiod">
            <xsl:choose>
              <xsl:when test="local-name(.) = 'TimeInstant'">start=<xsl:value-of select="gml:timePosition"/>; end=<xsl:value-of select="gml:timePosition"/></xsl:when>
              <xsl:otherwise>start=<xsl:value-of select="gml:beginPosition"/>; end=<xsl:value-of select="gml:endPosition"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
-->        
        <xsl:variable name="dateStart">
            <xsl:choose>
              <xsl:when test="local-name(.) = 'TimeInstant'"><xsl:value-of select="gml:timePosition"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="gml:beginPosition"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dateEnd">
            <xsl:choose>
              <xsl:when test="local-name(.) = 'TimeInstant'"><xsl:value-of select="gml:timePosition"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="gml:endPosition"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <dct:temporal>
          <dct:PeriodOfTime>
            <schema:startDate rdf:datatype="{$xsd}date"><xsl:value-of select="$dateStart"/></schema:startDate>
            <schema:endDate rdf:datatype="{$xsd}date"><xsl:value-of select="$dateEnd"/></schema:endDate>
          </dct:PeriodOfTime>
        </dct:temporal>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  
<!-- Dates of publication, last revision, creation -->  

  <xsl:template name="ResourceDates" match="gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation">
    <xsl:apply-templates select="gmd:date/gmd:CI_Date"/>
  </xsl:template>
  
<!-- Generic date template -->  

  <xsl:template name="Dates" match="gmd:date/gmd:CI_Date">
    <xsl:param name="date">
      <xsl:value-of select="gmd:date/gco:Date"/>
    </xsl:param>
    <xsl:param name="type">
      <xsl:value-of select="gmd:dateType/gmd:CI_DateTypeCode/@codeListValue"/>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$type = 'publication'">
        <dct:issued rdf:datatype="{$xsd}date">
          <xsl:value-of select="$date"/>
        </dct:issued>
      </xsl:when>
      <xsl:when test="$type = 'revision'">
        <dct:modified rdf:datatype="{$xsd}date">
          <xsl:value-of select="$date"/>
        </dct:modified>
      </xsl:when>
      <xsl:when test="$type = 'creation'">
        <dct:created rdf:datatype="{$xsd}date">
          <xsl:value-of select="$date"/>
        </dct:created>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

<!-- Constraints related to access and use -->

  <xsl:template name="ConstraintsRelatedToAccesAndUse" match="gmd:identificationInfo[1]/*/gmd:resourceConstraints/*">
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="LimitationsOnPublicAccess">
      <xsl:value-of select="gmd:MD_LegalConstraints/gmd:otherConstraints/gco:CharacterString"/>
    </xsl:param>
    <xsl:for-each select="gmd:useLimitation">
      <xsl:choose>
<!-- In case the rights/licence URL is NOT provided -->      
        <xsl:when test="gco:CharacterString">                                                                       
          <dct:rights>
            <dct:RightsStatement>
              <rdfs:label xml:lang="{$MetadataLanguage}"><xsl:value-of select="normalize-space(gco:CharacterString)"/></rdfs:label>
            </dct:RightsStatement>
          </dct:rights>
        </xsl:when>
<!-- In case the rights/licence URL is provided -->      
        <xsl:when test="gmx:Anchor/@xlink:href">
          <dct:rights>
            <dct:RightsStatement rdf:about="{gmx:Anchor/@xlink:href}">
              <rdfs:label xml:lang="{$MetadataLanguage}"><xsl:value-of select="normalize-space(gmx:Anchor)"/></rdfs:label>
            </dct:RightsStatement>
          </dct:rights>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="gmd:otherConstraints">
      <xsl:if test="$profile = 'extended'">
        <dct:accessRights>
          <dct:RightsStatement>
            <rdfs:label xml:lang="{$MetadataLanguage}"><xsl:value-of select="normalize-space(gco:CharacterString)"/></rdfs:label>
          </dct:RightsStatement>
        </dct:accessRights>
      </xsl:if>
    </xsl:for-each>
<!--    
    <xsl:for-each select="gmd:accessConstraints">
      <dct:accessRights rdf:resource="{$MD_RestrictionCode}_{gmd:MD_RestrictionCode/@codeListValue}"/>
    </xsl:for-each>
    <xsl:for-each select="gmd:classification">
      <dct:accessRights rdf:resource="{$MD_ClassificationCode}_{gmd:MD_ClassificationCode/@codeListValue}"/>
    </xsl:for-each>
-->    
  </xsl:template>
  
<!-- Keyword -->  

  <xsl:template name="Keyword" match="gmd:identificationInfo/*/gmd:descriptiveKeywords/gmd:MD_Keywords">
    <xsl:param name="MetadataLanguage"/>
    <xsl:param name="OriginatingControlledVocabulary">
      <xsl:for-each select="gmd:thesaurusName/gmd:CI_Citation">
        <rdfs:label xml:lang="{$MetadataLanguage}">
          <xsl:value-of select="gmd:title/gco:CharacterString"/>
        </rdfs:label>
        <xsl:apply-templates select="gmd:date/gmd:CI_Date"/>
      </xsl:for-each>
    </xsl:param>
    <xsl:for-each select="gmd:keyword">
      <xsl:variable name="lckw" select="translate(gco:CharacterString,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:choose>
        <xsl:when test="$OriginatingControlledVocabulary = ''">
          <dcat:keyword xml:lang="{$MetadataLanguage}"><xsl:value-of select="gco:CharacterString"/></dcat:keyword>
        </xsl:when>
        <xsl:otherwise>
          <dcat:theme>
            <xsl:choose>
<!-- In case the concept's URI is NOT provided -->              
              <xsl:when test="gco:CharacterString">
                <skos:Concept>
                  <skos:prefLabel xml:lang="{$MetadataLanguage}">
                    <xsl:value-of select="gco:CharacterString"/>
                  </skos:prefLabel>
                  <skos:inScheme>
                    <skos:ConceptScheme>
                      <xsl:copy-of select="$OriginatingControlledVocabulary"/>
                    </skos:ConceptScheme>
                  </skos:inScheme>
                </skos:Concept>
              </xsl:when>
<!-- In case the concept's URI is provided -->              
              <xsl:when test="gmx:Anchor/@xlink:href">
                <skos:Concept rdf:about="{gmx:Anchor/@xlink:href}">
                  <skos:prefLabel xml:lang="{$MetadataLanguage}">
                    <xsl:value-of select="gmx:Anchor"/>
                  </skos:prefLabel>
                  <skos:inScheme>
                    <skos:ConceptScheme>
                      <xsl:copy-of select="$OriginatingControlledVocabulary"/>
                    </skos:ConceptScheme>
                  </skos:inScheme>
                </skos:Concept>
              </xsl:when>
            </xsl:choose>
          </dcat:theme>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

<!-- Topic category -->

  <xsl:template name="TopicCategory" match="gmd:identificationInfo/*/gmd:topicCategory">
    <xsl:param name="TopicCategory"><xsl:value-of select="gmd:MD_TopicCategoryCode"/></xsl:param>
    <dct:subject rdf:resource="{$TopicCategoryCodelistUri}/{$TopicCategory}"/>
  </xsl:template>

<!-- Spatial resolution -->

  <xsl:template name="SpatialResolution" match="gmd:identificationInfo/*/gmd:spatialResolution/gmd:MD_Resolution">
<!-- dcat:granularity is no longer existing -->  
<!--
    <xsl:for-each select="gmd:distance/gco:Distance">
      <dcat:granularity rdf:datatype="{$xsd}string"><xsl:value-of select="."/> <xsl:value-of select="@uom"/></dcat:granularity>
    </xsl:for-each>
    <xsl:for-each select="gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator">
      <dcat:granularity rdf:datatype="{$xsd}string">1/<xsl:value-of select="gco:Integer"/></dcat:granularity>
    </xsl:for-each>
-->    
  </xsl:template>

<!-- Character encoding -->

  <xsl:template name="CharacterEncoding" match="gmd:characterSet/gmd:MD_CharacterSetCode">
    <cnt:characterEncoding rdf:datatype="{$xsd}string"><xsl:value-of select="@codeListValue"/></cnt:characterEncoding>
  </xsl:template>

<!-- Encoding -->

  <xsl:template name="Encoding" match="gmd:distributionFormat/gmd:MD_Format/gmd:name/gco:CharacterString">
    <dct:format rdf:parseType="Resource">
      <rdfs:label><xsl:value-of select="."/></rdfs:label>
    </dct:format>
  </xsl:template>
  
<!-- Maintenance information -->

  <xsl:template name="MaintenanceInformation" match="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode">
<!-- The following parameter maps frequency codes used in ISO 19139 metadata to the corresponding ones of the Dublin Core Collection Description Frequency Vocabulary (when available). -->
    <xsl:param name="FrequencyCodeURI">
      <xsl:if test="@codeListValue != ''">
        <xsl:choose>
          <xsl:when test="@codeListValue = 'continual'">
            <xsl:value-of select="concat($cldFrequency,'continuous')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'continual'">
            <xsl:value-of select="concat($cldFrequency,'continuous')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'daily'">
            <xsl:value-of select="concat($cldFrequency,'daily')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'weekly'">
            <xsl:value-of select="concat($cldFrequency,'weekly')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'fortnightly'">
            <xsl:value-of select="concat($cldFrequency,'biweekly')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'monthly'">
            <xsl:value-of select="concat($cldFrequency,'monthly')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'quarterly'">
            <xsl:value-of select="concat($cldFrequency,'quarterly')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'biannually'">
            <xsl:value-of select="concat($cldFrequency,'biennial')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'annually'">
            <xsl:value-of select="concat($cldFrequency,'annual')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'asNeeded'">
<!--          
            <xsl:value-of select="concat($cldFrequency,'??')"/>
-->            
          </xsl:when>
          <xsl:when test="@codeListValue = 'irregular'">
            <xsl:value-of select="concat($cldFrequency,'irregular')"/>
          </xsl:when>
          <xsl:when test="@codeListValue = 'notPlanned'">
<!--          
            <xsl:value-of select="concat($cldFrequency,'??')"/>
-->            
          </xsl:when>
          <xsl:when test="@codeListValue = 'unknown'">
<!--          
            <xsl:value-of select="concat($cldFrequency,'??')"/>
-->            
          </xsl:when>
        </xsl:choose>
      </xsl:if>
    </xsl:param>
    <xsl:if test="$FrequencyCodeURI != ''">
      <dct:accrualPeriodicity rdf:resource="{$FrequencyCodeURI}"/>
    </xsl:if>      
  </xsl:template>

<!-- Coordinate reference system -->

  <xsl:template name="CoordinateReferenceSystem" match="gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code">
<!-- TBD -->  
  </xsl:template>

</xsl:transform>
