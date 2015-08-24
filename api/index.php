<?php

// The API

  $apiSrcRep = "https://webgate.ec.europa.eu/CITnet/stash/projects/ODCKAN/repos/iso-19139-to-dcat-ap/browse/api";

  require('./lib/composer/vendor/autoload.php');

  $outputSchemas = array();
  $outputSchemas['core'] = array(
    'label' => 'DCAT-AP',
    'description' => 'TBD',
    'url' => 'TBD',
    'xslt' => 'https://webgate.ec.europa.eu/CITnet/stash/projects/ODCKAN/repos/iso-19139-to-dcat-ap/browse/iso-19139-to-dcat-ap.xsl?raw',
    'params' => array(
      'profile' => 'core'
    )
  );
  $outputSchemas['extended'] = array(
    'label' => 'GeoDCAT-AP',
    'description' => 'TBD',
    'url' => 'TBD',
    'xslt' => 'https://webgate.ec.europa.eu/CITnet/stash/projects/ODCKAN/repos/iso-19139-to-dcat-ap/browse/iso-19139-to-dcat-ap.xsl?raw',
    'params' => array(
      'profile' => 'extended'
    )
  );
  $defaultOutputSchema = 'core';


  $outputFormats = array();
//  $outputFormats['text/html'] = array('HTML+RDFa','');
  $outputFormats['application/rdf+xml'] = array('RDF/XML','rdf');
  $outputFormats['text/turtle'] = array('Turtle','turtle');
  $outputFormats['text/n3'] = array('N3','n3');
  $outputFormats['application/n-triples'] = array('N-Triples','ntriples');
  $outputFormats['application/ld+json'] = array('JSON-LD','jsonld');
  $defaultOutputFormat = 'application/rdf+xml';

  function returnHttpError($code) {
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
    echo '<!DOCTYPE html><html><head><title>' . $title . '</title></head><body><h1>' . $title . '</h1><p>' . $content . '</p></body></html>';
    exit;
  }


  if (isset($_GET['src'])) {

    $xmluri = $_GET['src'];

    $outputSchema = $outputSchemas[$defaultOutputSchema];
    $xsluri = $outputSchema['xslt'];
    if (isset($_GET['outputSchema'])) {
      if (isset($outputSchemas[$_GET['outputSchema']])) {
        $outputSchema = $_GET['outputSchema'];
        $xsluri = $outputSchemas[$outputSchema]['xslt'];
      }
      else {
        returnHttpError(404);
      }
    }

    $xml = new DOMDocument;
    if (!$xml->load($xmluri)) {
      returnHttpError(404);
    }

    $xsl = new DOMDocument;
    if (!$xsl->load($xsluri)) {
      returnHttpError(404);
    }

    $proc = new XSLTProcessor();
    $proc->importStyleSheet($xsl);

    foreach ($outputSchemas[$outputSchema]['params'] as $k => $v) {
      $proc->setParameter("", $k, $v);
    }

    if (!$rdf = $proc->transformToXML($xml)) {
      returnHttpError(404);
    }

    $rdfxmlURL = 'http://' . $_SERVER["SERVER_NAME"] . str_replace($_SERVER["QUERY_STRING"], '', $_SERVER["REQUEST_URI"]) . 'outputSchema=' . rawurlencode($outputSchema) . '&outputFormat=' . rawurlencode("application/rdf+xml") . '&src=' . rawurlencode($_GET['src']);

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
      preg_match_all("/[a-zA-Z0-9]+\/[a-zA-Z0-9\!\#\$\&\-\^_\.\+]+/",$_SERVER['HTTP_ACCEPT'],$matches);
      if (count($matches[0]) == 0) {
        returnHttpError(415);
      }
      else {
        $acceptedFormats = $matches[0];
        $supportedFormats = array_keys($outputFormats);
        $candidateFormats = array_intersect($supportedFormats, $acceptedFormats);
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

    EasyRdf_Namespace::set('adms', 'http://www.w3.org/ns/adms#');
    EasyRdf_Namespace::set('cnt', 'http://www.w3.org/2011/content#');
    EasyRdf_Namespace::set('dc', 'http://purl.org/dc/elements/1.1/');
    EasyRdf_Namespace::set('gsp', 'http://www.opengis.net/ont/geosparql#');
    EasyRdf_Namespace::set('locn', 'http://www.w3.org/ns/locn#');
    $graph = new EasyRdf_Graph;
    $graph->parse($rdf, "rdfxml", $rdfxmlURL);

    header("Content-type: " . $outputFormat);
    echo $graph->serialise($outputFormats[$outputFormat][1]);
    exit;
/*
    if ($outputFormat == 'text/html') {
      $xml = new DOMDocument;
      $xml->loadXML($rdf) or die();
      $xsl = new DOMDocument;
      $xsl->load("");
      $proc = new XSLTProcessor();
      $proc->importStyleSheet($xsl);
      echo $proc->transformToXML($xml);
      exit;
    }
    else {
      echo $graph->serialise($outputFormats[$outputFormat][1]);
      exit;
    }
*/
  }

// Variables for API landing page.

  $title = "GeoDCAT-AP API";
  $exampleSrcURL = "";
  $footer = '<p>' . $title . ' @ Stash: <a href="' . $apiSrcRep . '">' . $apiSrcRep . '</a></p>';

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title><?php echo $title; ?></title>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  </head>
  <body>
    <header><h1><?php echo $title; ?></h1></header>
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
          <span style="float:right">
            <input type="submit" id="transform" value="Transform"/>
          </span>
        </h1>
        <textarea id="src" name="src" title="Copy &amp; paste the URL of ISO 19139 records" placeholder="Copy &amp; paste the URL of ISO 19139 records"><?php echo $exampleSrcURL?></textarea>
        <div style="height:2em">
          <span style="float:right;">
            <label for="outputFormat">Output format : </label>
            <select id="outputFormat" name="outputFormat">
<?php

  foreach ($outputFormats as $k => $v) {
    $selected = '';
    if ($k == $defaultOutputFormat) {
      $selected = ' selected="selected"';
    }
    echo '              <option value="' . $k . '"' . $selected . '>' . $v[0] . '</option>' . "\n";
  }

?>
            </select>
          </span>
        </div>
      </form>
      <section>
        <h3>Usage notes</h3>
        <p>Copy &amp; paste the URL of a file or of a CSW request returning ISO 19139 records.</p>
        <p>Supported CSW request types: <code>GetRecords</code>, <code>GetRecordById</code>.</p>
        <p>Supported CSW output schema: <code>http://www.isotc211.org/2005/gmd</code></p>
        <p><strong>NB</strong>: The current version of the API supports only CSW calls using the <code>GET</code> HTTP method.</p>
        <p><em>A description of the GeoDCAT-AP API is available on the <a href="<?php echo $apiSrcRep; ?>">API's Stash repository</a>.</em></p>
      </section>
    </section>
    <aside>
    </aside>
    <footer><?php echo $footer; ?></footer>
  </body>
</html>
