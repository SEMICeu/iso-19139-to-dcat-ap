
# The GeoDCAT-AP API (GeoDCAT-API)

This API is a proof-of-concept of the implementation of GeoDCAT-AP in an [OGC CSW (Catalog Service for the Web)](http://www.opengeospatial.org/standards/cat), re-using the standard CSW interface, and supporting in addition [HTTP content negotiation](https://tools.ietf.org/html/rfc7231#section-3.4).

More precisely, GeoDCAT-API uses the standard CSW parameters `outputSchema` and `outputFormat` to determine, respectively, (a) the GeoDCAT-AP profile to be used (core or extended), and (b) the RDF serialisation to be returned.

The document containing the ISO 19139 records to be transformed is specified by a GeoDCAT-API-specific parameter `src`, which is not part of the CSW interface. 

The API uses the [GeoDCAT-AP XSLT](https://webgate.ec.europa.eu/CITnet/stash/projects/ODCKAN/repos/iso-19139-to-dcat-ap) to transform ISO 19139 records into GeoDCAT-AP. As such, the API works both on static files including the records, and on the CSW output of a `GetRecords` or `GetRecordById` request.

A working demo of GeoDCAT-API is available at: 

http://geodcat-ap.semic.eu:8890/api/

# API specification

## Supported HTTP methods

The current version of GeoDCAT-API supports only the HTTP `GET` method. As a consequence, it can be used only on CSWs supporting `GET` requests.

## API parameters

### Request

<table width="100%">
  <thead>
    <tr>
      <th>Parameter</th>
      <th>Description</th>
      <th colspan="2">Possible values</th>
      <th>Default value</th>
      <th>Notes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td rowspan="2"><code>ouputSchema</code></td>
      <td rowspan="2">The GeoDCAT-AP profile to be used for the transformation</td>
      <td><code>core</code></td><td>(DCAT-AP)</td>
      <td rowspan="2"><code>core</code></td>
      <td rowspan="2">
        <p>If this parameter is omitted, the API uses the "core" profile as default.</p>
        <p>The "core" profile is labelled "DCAT-AP", since it returns just the metadata elements supported in DCAT-AP.</p>
        <p><strong>NB</strong>: The current values of this parameter are provisional, and they are meant to be replaced by the official namespace URIs of DCAT-AP and GeoDCAT-AP, when available.</p>
      </td>
    </tr>
    <tr>
      <td><code>extended</code></td><td>(GeoDCAT-AP)</td>
    </tr>
    <tr>
      <td rowspan="6"><code>outputFormat</code></td>
      <td rowspan="6">The RDF serialisation to be returned</td>
      <td><code>application/rdf+xml</code></td><td>(<a href="http://www.w3.org/TR/rdf-syntax-grammar/">RDF/XML</a>)</td>
      <td rowspan="6">N/A</td>
      <td rowspan="6">If this parameter is omitted, the returned RDF serialisation is determined via HTTP content negotiation</td>
    </tr>
    <tr>
      <td><code>text/turtle</code></td><td>(<a href="http://www.w3.org/TR/turtle/">Turtle</a>)</td>
    </tr>
    <tr>
      <td><code>text/n3</code></td><td>(<a href="http://www.w3.org/TeamSubmission/n3/">Notation 3</a>)</td>
    </tr>
    <tr>
      <td><code>application/n-triples</code></td><td>(<a href="http://www.w3.org/TR/n-triples/">N-Triples</a>)</td>
    </tr>
    <tr>
      <td><code>application/ld+json</code></td><td>(<a href="http://www.w3.org/TR/json-ld/">JSON-LD</a>)</td>
    </tr>
    <tr>
      <td><code>text/html</code></td><td>(<a href="http://www.w3.org/TR/html-rdfa/">HTML+RDFa</a>)</td>
    </tr>
    <tr>
      <td><code>src</code></td>
      <td>The URL of the resource containing the ISO 19139 records to be tranformed</td>
      <tdi colspan="2">A URL</td>
      <td>N/A</td>
      <td></td>
    </tr>
  </tbody>
</table>

### Response

Besides the resulting RDF serialisation of the source ISO 19139 records, the API returns a set of HTTP [`Link`](https://tools.ietf.org/html/rfc5988) headers, and the corresponding HTML LINK elements in the HTML+RDFa serialisation.

<table width="100%">
  <thead>
    <tr>
      <th><a href="http://www.iana.org/assignments/link-relations/" title="IANA Link Relations">Relation type</a></th>
      <th>Type</th>
      <th>Title</th>
      <th>Target URI</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>derivedfrom</code></td>
      <td><code>application/xml</code></td>
      <td><code>ISO 19139</code></td>
      <td>The URL of the source document, containing the ISO 19139 records.</td>
    </tr>
    <tr>
      <td rowspan="2"><code>profile</code></td>
      <td rowspan="2">The media type of the document returned by the API.</td>
      <td><code>DCAT-AP</code></td>
      <td><code>core</code></td>
    </tr>
    <tr>
      <td><code>GeoDCAT-AP</code></td>
      <td><code>extended</code></td>
    </tr>
    <tr>
      <td><code>self</code></td>
      <td>The media type of the document returned by the API.</td>
      <td>The name of the returned RDF serialisation.</td>
      <td>The URL of the document returned by the API.</td>
    </tr>
    <tr>
      <td><code>alternate</code></td>
      <td>The media types of the alternative RDF serialisations supported by the API.</td>
      <td>The name of the relevant RDF serialisation.</td>
      <td>The URL of the document, encoded with the relevant RDF serialisation, as would be returned by the API.</td>
    </tr>
  </tbody>
</table>

# Implementation details

GeoDCAT-API is implemented in [PHP5](http://php.net/), and runs on top of an [Apache 2 HTTP server](http://httpd.apache.org/).

The [EasyRDF](http://www.easyrdf.org/) and the [ML/JSON-LD](https://github.com/lanthaler/JsonLD) PHP libraries are used to generate the supported RDF serialisations. The HTML+RDFa serialisation is generated by using the [DCAT-AP in HTML+RDFa](../../../dcat-ap-rdf2html/) XSLT.

# Installation instructions

GeoDCAT-API has been tested on both Linux and Windows, with Apache 2 and PHP 5.3.2 (or later) installed and running.

**NB**: GeoDCAT-API makes use of the [PHP XSL extension](http://php.net/manual/en/xsl.installation.php).

The repository includes all what is necessary, with the exception of EasyRDF and ML/JSON-LD, that must be installed separately by using [Composer](https://getcomposer.org/).

More precisely:

* Go to folder [`./lib/composer/`](./lib/composer/).
* [Download Composer](https://getcomposer.org/download/). E.g.: `curl -s https://getcomposer.org/installer | php`
* Run `php composer.phar install`

You will now be able to run the API from a Web folder.
