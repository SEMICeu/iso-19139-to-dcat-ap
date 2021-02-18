# Supported usage patterns for HTTP URIs

This section illustrates "where", in ISO 19139 metadata records, the XSLT expects to find HTTP URIs (if available), and how they are interpreted.

## Metadata URI: Metadata file identifier (ISO 19115)

### XPath

````
//gmd:fileIdentifier/gco:CharacterString
````

### Example

````xml
<gmd:fileIdentifier>
  <gco:CharacterString>
    http://some.site/resource/5d3166e1-0685-4a0a-bc0c-02cc7364191a
  </gco:CharacterString>
</gmd:fileIdentifier>
````

## Metadata standard URI: Metadata standard name (ISO 19115)

### XPath

````
//gmd:metadataStandardName/gmx:Anchor/@xlink:href
````

### Example

````xml
<gmd:metadataStandardName>
  <gmx:Anchor xlink:href="http://www.iso.org/iso/catalogue_detail.htm?csnumber=26020">
    ISO 19115
  </gmx:Anchor>
</gmd:metadataStandardName>
````

## Resource identifier: Unique Resource Identifier (INSPIRE); Resource identifier (ISO 19115)

### XPath

````
//gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:code/gco:CharacterString
````

### Example

````xml
<gmd:identifier>
  <gmd:RS_Identifier>
    <gmd:code>
      <gco:CharacterString>
        http://some.site/resource/947e5a55-e548-11e1-9105-0017085a97ab
      </gco:CharacterString>
    </gmd:code>
  </gmd:RS_Identifier>
<gmd:identifier>
````

## Keyword URI: Keyword (INSPIRE); Descriptive keyword (ISO 19115)

### XPath

````
//gmd:keyword/gmx:Anchor/@xlink:href
````

### Examples 

For the INSPIRE themes:

````xml
<gmd:keyword>
  <gmx:Anchor xlink:href="http://inspire.ec.europa.eu/theme/lc" xlink:title="Land cover">
    Land cover
  </gmx:Anchor>
</gmd:keyword>
````

For GEMET concepts:

````xml
<gmd:keyword>
  <gmx:Anchor xlink:href="http://www.eionet.europa.eu/gemet/en/concept/1337" xlink:title="coniferous forest">
    coniferous forest
  </gmx:Anchor>
</gmd:keyword>
````

<h2><a name="uri-geo-id">Geographic identifier URI: Geographic identifier (ISO 19115)</a></h2>

### XPath

````
//gmd:geographicIdentifier/gmd:MD_Identifier/gmd:code/gco:CharacterString
````

or

````
//gmd:geographicIdentifier/gmd:MD_Identifier/gmd:code/gmx:Anchor/@xlink:href
````

### Examples 

````xml
<gmd:geographicElement>
  <gmd:EX_GeographicDescription>
    <gmd:geographicIdentifier>
      <gmd:MD_Identifier>
        <gmd:code>
          <gco:CharacterString>http://publications.europa.eu/resource/authority/continent/EUROPE</gco:CharacterString>
        </gmd:code>
      </gmd:MD_Identifier>
    </gmd:geographicIdentifier>
  </gmd:EX_GeographicDescription>
</gmd:geographicElement>
````

````xml
<gmd:geographicElement>
  <gmd:EX_GeographicDescription>
    <gmd:geographicIdentifier>
      <gmd:MD_Identifier>
        <gmd:code>
          <gmx:Anchor xlink:href="http://publications.europa.eu/resource/authority/continent/EUROPE" title="Europe">Europe</gmx:Anchor>
        </gmd:code>
      </gmd:MD_Identifier>
    </gmd:geographicIdentifier>
  </gmd:EX_GeographicDescription>
</gmd:geographicElement>
````

<h2><a name="uri-conformity-specification">Conformity specification URI: Conformity specification (INSPIRE / ISO 19115)</a></h2>

### XPath

````
//gmd:specification/gmd:CI_Citation/gmd:title/gmx:Anchor/P@xlink:href
````

### Example 

````xml
<gmd:specification>
  <gmd:CI_Citation>
    <gmd:title>
      <gmx:Anchor xlink:href="http://data.europa.eu/eli/reg/2010/1089/oj">
        COMMISSION REGULATION (EU) No 1089/2010 of 23 November 2010 implementing Directive 2007/2/EC of the 
        European Parliament and of the Council as regards interoperability of spatial data sets and services
      </gmx:Anchor>
    </gmd:title>
      ...
  </gmd:CI_Citation>
</gmd:specification>
````

## Use conditions / licence URI: Conditions for access and use (INSPIRE); Use limitation (ISO 19115)

### XPath

````
//gmd:useConstraints/gmd:otherConstraints/gmx:Anchor/@xlink:href
````

### Example 

````xml
<gmd:useConstraints>
  <gmd:otherConstraints>
    <gmx:Anchor xlink:href="http://inspire.ec.europa.eu/metadata-codelist/LimitationsOnPublicAccess/INSPIRE_Directive_Article13_1a">
      Creative Commons - Attribution 4.0 International - CC BY
    </gmx:Anchor>
  </gmd:otherConstraints>
</gmd:useConstraints>
````

## Access restrictions URI: Limitations of public access (INSPIRE); Access constraints, other constraints (ISO 19115)

### XPath

````
//gmd:accessConstraints/gmd:otherConstraints/gmx:Anchor/@xlink:href
````

### Example 

````xml
<gmd:accessConstraints>
  <gmd:otherConstraints>
    <gmx:Anchor xlink:href="http://inspire.ec.europa.eu/metadata-codelist/LimitationsOnPublicAccess/INSPIRE_Directive_Article13_1a">
      Public access limited according to Article 13(1)(a) of the INSPIRE Directive
    </gmx:Anchor>
  </gmd:otherConstraints>
</gmd:accessConstraints>
````

## Agent URI (metadata): Metadata point of contact (INSPIRE / ISO 19115); Agent URI (resource): Responsible organisation (INSPIRE); Responsible party (ISO 19115)

### XPath

For individuals:

````
//gmd:CI_ResponsibleParty/gmd:individualName/gmx:Anchor/@xlink:href
````

For organisations:

````
//gmd:CI_ResponsibleParty/gmd:organizationName/gmx:Anchor/@xlink:href
````

### Example 

````xml
<gmd:CI_ResponsibleParty>
  <gmd:individualName>
    <gmx:Anchor xlink:href="http://orcid.org/0000-0000-0000-0000">
      Joe Smith
    </gmx:Anchor>
  </gmd:individualName>
  <gmd:organisationName>
    <gmx:Anchor xlink:href="http://some.company.com/">
      SomeCompany Ltd.
    </gmx:Anchor>
  </gmd:organisationName>
<gmd:CI_ResponsibleParty>
````

## 
<h2><a name="uri-crs">Coordinate reference system URI: Coordinate reference system (INSPIRE); Reference system (ISO 19115)</a></h2>

### XPath

````
//gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString
````

### Example 

````xml
<gmd:referenceSystemIdentifier>
  <gmd:RS_Identifier>
    <gmd:code>
      <gco:CharacterString>
        http://www.opengis.net/def/crs/EPSG/0/27700 
      </gco:CharacterString>
    </gmd:code>
  </gmd:RS_Identifier>
</gmd:referenceSystemIdentifier>
````

## Temporal reference system URI: Temporal reference system (INSPIRE); Reference system (ISO 19115)

TBD

<h2><a name="uri-format">Format URI: Encoding (INSPIRE); Format (ISO 19115)</a></h2>

### XPath

````
//gmd:MD_Format/gmd:name/gmx:Anchor/@xlink:href
````

### Example 

````xml
<gmd:MD_Format>
  <gmd:name>
    <gmx:Anchor xlink:href="http://publications.europa.eu/resource/authority/file-type/TIFF">
      TIFF
    </gmx:Anchor>
  </gmd:name>
  <gmd:version>
    <gco:CharacterString>unknown</gco:CharacterString>
  </gmd:version>
</gmd:MD_Format>
````
