<?php

  error_reporting(0);

// The API

  $apiSrcRep = "https://github.com/SEMICeu/iso-19139-to-dcat-ap/tree/master/api";

// Variables for API landing page.

  $title = "GeoDCAT-AP API";
  $subtitle = "ISO 19139 records in RDF";
//  $logo = "https://joinup.ec.europa.eu/sites/default/files/ckeditor_files/images/DCAT-AP-GEO.png";
//  $logo = "https://joinup.ec.europa.eu/sites/default/files/inline-images/DCAT-AP-GEO%281%29.png";
  $logo = "./css/isa-dcat-ap-geo-logo.png";
  $logotitle = "GeoDCAT-AP";
  $logourl = "https://joinup.ec.europa.eu/node/139283/";
//  $head  = '<link rel="stylesheet" type="text/css" href="http://geodcat-ap.semic.eu:8890/common/normalize.css"/>' . "\n";
  $head  = '<link rel="stylesheet" type="text/css" href="./css/normalize.css"/>' . "\n";
  $head .= '<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:400,400italic,600,600italic,300"/>' . "\n";
//  $head .= '<link rel="stylesheet" type="text/css" href="http://geodcat-ap.semic.eu:8890/common/screen.css"/>' . "\n";
  $head .= '<link rel="stylesheet" type="text/css" href="./css/screen.css"/>' . "\n";
  $head .= '<link rel="stylesheet" type="text/css" href="./css/style.css"/>' . "\n";
//  $footer = '<p>' . $title . ' @ Stash: <a href="' . $apiSrcRep . '">' . $apiSrcRep . '</a></p>';
  $footer = '<p>This work is jointly supported by the <a href="https://joinup.ec.europa.eu/community/are3na/" target="_blank">ARe3NA</a> and <a href="https://joinup.ec.europa.eu/community/semic/" target="_blank">SEMIC</a> Actions of the <a href="http://ec.europa.eu/isa/" target="_blank">EU ISA Programme</a>.</p>';
  $footer .= '<p>';
//  $footer .= ' <a href="https://joinup.ec.europa.eu/community/are3na/" target="_blank"><img alt="ARe3NA" src="https://joinup.ec.europa.eu/sites/default/files/imagecache/community_logo/22/2d/97/Are3na_small.png" width="70" height="70"></a> ';
  $footer .= ' <a href="https://joinup.ec.europa.eu/community/are3na/" target="_blank"><img alt="ARe3NA" src="./css/isa-are3na-logo.jpg" width="70" height="70"></a> ';
//  $footer .= ' <a href="https://joinup.ec.europa.eu/community/semic/" target="_blank"><img alt="SEMIC" src="https://joinup.ec.europa.eu/sites/default/files/imagecache/community_logo/cb/8f/68/SEMIC_Community_Logo.png" width="70" height="70"></a> ';
  $footer .= ' <a href="https://joinup.ec.europa.eu/community/semic/" target="_blank"><img alt="SEMIC" src="./css/isa-semic-logo.png" height="70"></a> ';
//  $footer .= ' <a href="http://ec.europa.eu/isa/" target="_blank"><img alt="ISA" src="http://joinup.ec.europa.eu/sites/default/files/ckeditor_files/images/isa_logo.png" width="70" height="70"></a> ';
  $footer .= ' <a href="http://ec.europa.eu/isa/" target="_blank"><img alt="ISA" src="./css/isa-logo.png" height="70"></a> ';
  $footer .= '</p>';
  $exampleSrcURL = "https://sdi.eea.europa.eu/catalogue/srv/eng/csw?request=GetRecords&service=CSW&version=2.0.2&namespace=xmlns%28csw=http://www.opengis.net/cat/csw%29&resultType=results&outputSchema=http://www.isotc211.org/2005/gmd&outputFormat=application/xml&typeNames=csw:Record&elementSetName=full&constraintLanguage=CQL_TEXT&constraint_language_version=1.1.0&maxRecords=20";
//  $exampleSrcURL = "https://sdi.eea.europa.eu/catalogue/srv/eng/csw?request=GetRecords&service=CSW&version=2.0.2&namespace=xmlns%28csw=http://www.opengis.net/cat/csw%29&resultType=results&outputSchema=http://www.isotc211.org/2005/gmd&outputFormat=application/xml&typeNames=csw:Record&elementSetName=full&constraintLanguage=CQL_TEXT&constraint_language_version=1.1.0&maxRecords=20&startPosition=1&constraint=AnyText%20like%20%27service%27";

// Loading the required libraries

  require('./lib/composer/vendor/autoload.php');

// Output schemas

  $outputSchemas = array();
  $outputSchemas['core'] = array(
    'label' => 'DCAT-AP',
    'description' => 'TBD',
    'url' => 'TBD',
    'xslt' => 'https://raw.githubusercontent.com/SEMICeu/iso-19139-to-dcat-ap/master/iso-19139-to-dcat-ap.xsl',
//    'xslt' => './lib/xslt/iso-19139-to-dcat-ap.xsl',
    'params' => array(
      'profile' => 'core'
    )
  );
  $outputSchemas['extended'] = array(
    'label' => 'GeoDCAT-AP',
    'description' => 'TBD',
    'url' => 'TBD',
    'xslt' => 'https://raw.githubusercontent.com/SEMICeu/iso-19139-to-dcat-ap/master/iso-19139-to-dcat-ap.xsl',
//    'xslt' => './lib/xslt/iso-19139-to-dcat-ap.xsl',
    'params' => array(
      'profile' => 'extended'
    )
  );
  $defaultOutputSchema = 'core';

// XSLT to generate the HTML+RDFa serialisation

  $rdf2rdfa = "https://raw.githubusercontent.com/SEMICeu/dcat-ap-rdf2html/master/dcat-ap-rdf2rdfa.xsl";
//  $rdf2rdfa = "../../dcat-ap-rdf2html/dcat-ap-rdf2rdfa.xsl";

// Output formats

  $outputFormats = array();
  $outputFormats['text/html'] = array('HTML+RDFa','');
  $outputFormats['application/rdf+xml'] = array('RDF/XML','rdf');
  $outputFormats['text/turtle'] = array('Turtle','turtle');
  $outputFormats['text/n3'] = array('N3','n3');
  $outputFormats['application/n-triples'] = array('N-Triples','ntriples');
  $outputFormats['application/ld+json'] = array('JSON-LD','jsonld');
//  $defaultOutputFormat = 'application/rdf+xml';
  $defaultOutputFormat = 'text/html';

// HTTP codes & corresponding pages

  function returnHttpError($code) {
    global $head;
    $title =  $_SERVER["SERVER_PROTOCOL"] . ' ' . $code;
    $content = '';
    switch ($code) {
      case 300:
        $title .= ' Multiple Choices';
        $content = '';
        break;
      case 404:
        $title .= ' Not Found';
        $content = 'The requested URL <code>' . $_SERVER["REQUEST_URI"] . '</code> was not found on this server.';
        break;
      case 415:
        $title .= ' Unsupported Media Type';
        $content = 'The server does not support the media type transmitted in the request.';
        break;
    }
    http_response_code($code);
    echo '<!DOCTYPE html><html><head><title>' . $title . '</title>' . str_replace("\n", "", $head) . '</head><body><header><h1>' . $title . '</h1></header><section><p>' . $content . '</p></section></body></html>';
    exit;
  }

// Setting the output schema

  if (isset($_GET['src'])) {

    $xmluri = $_GET['src'];

    $outputSchema = $defaultOutputSchema;
    $xsluri = $outputSchemas[$outputSchema]['xslt'];
    if (isset($_GET['outputSchema'])) {
      if (isset($outputSchemas[$_GET['outputSchema']])) {
        $outputSchema = $_GET['outputSchema'];
        $xsluri = $outputSchemas[$outputSchema]['xslt'];
      }
      else {
        returnHttpError(404);
      }
    }

// Loading the source document 

    $xml = new DOMDocument;
    if (!$xml->load($xmluri)) {
      returnHttpError(404);
    }

// Loading the XSLT to transform the source document into RDF/XML

    $xsl = new DOMDocument;
    if (!$xsl->load($xsluri)) {
      returnHttpError(404);
    }

// Transforming the source document into RDF/XML

    $proc = new XSLTProcessor();
    $proc->importStyleSheet($xsl);

    foreach ($outputSchemas[$outputSchema]['params'] as $k => $v) {
      $proc->setParameter("", $k, $v);
    }

    if (!$rdf = $proc->transformToXML($xml)) {
      returnHttpError(404);
    }

    $outputFormat = $defaultOutputFormat;
    if (isset($_GET['outputFormat'])) {
      if (!isset($outputFormats[$_GET['outputFormat']])) {
        returnHttpError(415);
      }
      else {
        $outputFormat = $_GET['outputFormat'];
      }
    }
    else {
      preg_match_all("/[a-zA-Z0-9]+\/[a-zA-Z0-9\!\#\$\&\-\^_\.\+]+/", $_SERVER["HTTP_ACCEPT"], $matches);
      if (count($matches[0]) == 0) {
        returnHttpError(415);
      }
      else {
        $acceptedFormats = $matches[0];
        $supportedFormats = array_keys($outputFormats);
        $candidateFormats = array_values(array_intersect($supportedFormats, $acceptedFormats));
        switch (count($candidateFormats)) {
          case 0:
            returnHttpError(415);
            break;
          case 1:
            $outputFormat = $candidateFormats[0];
            break;
          default:
            returnHttpError(300);
            break;
        }
      }
    }

// Related resources

// The metadata profile of the output resource (output schema)
    $link[] = array(
      "href" => $outputSchema,
      "rel" => "profile",
      "type" => $outputFormat,
      "title" => $outputSchemas[$outputSchema]["label"]
    );
// The input resource
    $link[] = array(
      "href" => $xmluri,
      "rel" => "derivedfrom",
      "type" => "application/xml",
      "title" => "ISO 19139"
    );
// The available serialisations of the output resource (output format)
    foreach ($outputFormats as $k => $v) {
      $uri = str_replace($_SERVER['QUERY_STRING'], '', $_SERVER['REQUEST_URI']) . 'outputSchema=' . rawurlencode($outputSchema) . '&src=' . rawurlencode($xmluri) . '&outputFormat=' . rawurlencode($k);
      $rel = 'alternate';
      if ($k == $outputFormat) {
        $rel = 'self';
      }
      $link[] = array(
        "href" => $uri,
        "rel" => $rel,
        "type" => $k,
        "title" => $v[0]
      );
      $outputFormats[$k][] = $uri;
    }

// Building HTTP "Link" headers and HTML "link" elements pointing to the related resources

    $linkHTTP = array();
    $linkHTML = array();
    foreach ($link as $v) {
      $linkHTTP[] = '<' . $v["href"] . '>; rel="' . $v["rel"] . '"; type="' . $v["type"] . '"; title="' . $v["title"] . '"';
      $linkHTML[] = '<link href="' . $v["href"] . '" rel="' . $v["rel"] . '" type="' . $v["type"] . '" title="' . $v["title"] . '"/>';
    }

// Setting namespace prefixes

    EasyRdf_Namespace::set('adms', 'http://www.w3.org/ns/adms#');
    EasyRdf_Namespace::set('cnt', 'http://www.w3.org/2011/content#');
    EasyRdf_Namespace::set('dc', 'http://purl.org/dc/elements/1.1/');
    EasyRdf_Namespace::set('dcat', 'http://www.w3.org/ns/dcat#');
    EasyRdf_Namespace::set('dqv', 'http://www.w3.org/ns/dqv#');
    EasyRdf_Namespace::set('geodcatap', 'http://data.europa.eu/930/');
    EasyRdf_Namespace::set('gsp', 'http://www.opengis.net/ont/geosparql#');
    EasyRdf_Namespace::set('locn', 'http://www.w3.org/ns/locn#');
    EasyRdf_Namespace::set('prov', 'http://www.w3.org/ns/prov#');

// Creating the RDF graph from the RDF/XML serialisation

    $graph = new EasyRdf_Graph;
//    $graph->parse($rdf, "rdfxml", $outputFormats['application/rdf+xml'][2]);
    $graph->parse($rdf);

// Sending HTTP headers

    header("Content-type: " . $outputFormat . ';charset=utf-8');
    header('Link: ' . join(', ', $linkHTTP));

    if ($outputFormat == 'text/html') {
      $xml = new DOMDocument;
// From the raw RDF/XML output of the stylesheet
      $xml->loadXML($rdf) or die();
// From the re-serialised RDF/XML output of the stylesheet
//      $xml->loadXML($graph->serialise("rdfxml")) or die();
      $xsl = new DOMDocument;
      $xsl->load($rdf2rdfa);
      $proc = new XSLTProcessor();
      $proc->importStyleSheet($xsl);
// The title of the HTML+RDFa
      $proc->setParameter('', 'title', $title);
// The URL of the repository
      $proc->setParameter('', 'home', $apiSrcRep);
// All what needs to be added in the HEAD of the HTML+RDFa document
      $head .= join("\n", $linkHTML) . "\n";
      $proc->setParameter('', 'head', $head);
      echo $proc->transformToXML($xml);
      exit;
    }
    else {
// Block added to enable pretty-print output of the JSON-LD serialisation, not supported in the current version of EasyRdf
// Predefined constants are as per ML/JsonLD - see: https://github.com/lanthaler/JsonLD/blob/master/JsonLD.php
      if ($outputFormat == 'application/ld+json') {
        echo json_encode(json_decode($graph->serialise($outputFormats[$outputFormat][1])), JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
      }
      else {
        echo $graph->serialise($outputFormats[$outputFormat][1]);
      }
// To be used when JSON-LD pretty-print will be supported in EasyRdf (see previous comment)      
//      echo $graph->serialise($outputFormats[$outputFormat][1]);
      exit;
    }

  }

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title><?php echo $title; ?></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<?php echo $head; ?>
  </head>
  <body>
    <header>
      <div class="logo"><a href="<?php echo $logourl; ?>" target="_blank"><img src="<?php echo $logo; ?>" title="<?php echo $logotitle; ?>" width="90" height="90"/></a></div>
      <h1><?php echo $title; ?></h1>
      <p class="subtitle"><?php echo $subtitle; ?></p>
    </header>
    <nav>
    </nav>
    <section id="input-box">
      <form id="api" action="." method="get">
        <h1>
          <label for="outputSchema">Output Schema : </label>
          <select id="outputSchema" name="outputSchema">
<?php

  foreach ($outputSchemas as $k => $v) {
    echo '            <option value="' . $k . '">' . $v['label'] . '</option>' . "\n";
  }

?>
          </select>
          <input style="float:right" type="submit" id="transform" value="Transform"/>
        </h1>
        <p><input type="url" required="required" id="src" name="src" title="Copy &amp; paste the URL of ISO 19139 records" placeholder="Copy &amp; paste the URL of ISO 19139 records" value="<?php echo $exampleSrcURL?>"/></p>
        <p style="float:right;">
          <label for="outputFormat">Output format : </label>
          <select id="outputFormat" name="outputFormat">
<?php

  foreach ($outputFormats as $k => $v) {
    $selected = '';
    if ($k == $defaultOutputFormat) {
      $selected = ' selected="selected"';
    }
    echo '            <option value="' . $k . '"' . $selected . '>' . $v[0] . '</option>' . "\n";
  }

?>
          </select>
        </p>
      </form>
    </section>
    <section>
      <h1>Usage notes</h1>
      <p>Copy &amp; paste the URL of a file or of a CSW request returning ISO 19139 records.</p>
      <p>Supported CSW request types: <code>GetRecords</code>, <code>GetRecordById</code>.</p>
      <p>Supported CSW output schema: <code>http://www.isotc211.org/2005/gmd</code></p>
      <p><strong>NB</strong>: The current version of the API supports only CSW calls using the <code>GET</code> HTTP method.</p>
      <p><em>A description of the GeoDCAT-AP API is available on the <a href="<?php echo $apiSrcRep; ?>">dedicated GitHub repository</a>.</em></p>
    </section>
    <aside>
    </aside>
    <footer><?php echo $footer; ?></footer>
  </body>
</html>
