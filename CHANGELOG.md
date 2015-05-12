# Changelog

Unless specified otherwise, the entries in this changelog apply to file [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl).

## 2015-05-12: Revised version (v0.4)
* Core and extended profiles revised to match with the current version of the DCAT-AP specification.
* Metadata and resource character encodings: ISO 19115 characterset codes have been mapped to the IANA character set names.
* Added metadata character encoding (only for the extended profile).
* Metadata description (metadata on metadata) typed as `dcat:CatalogRecord`, and partially moved to the core profile (as per the DCAT-AP specification). 
* Added licence and access rights to services.
* Revision to transformation rules for "service type".
* Moved "creation date" to the extended profile (it is not supported in DCAT-AP).
* Added bounding box encoding in WKT and GeoJSON.
* Fixed axis order to WKT and GeoJSON bounding box encodings.

## 2015-04-27: Revised version (v0.3)

* Added tentative revision to mappings for services:
    * All services are typed (`rdf:type`) as `dctype:Service`'s (only for the extended profile).
    * Discovery / catalogue services are typed (`rdf:type`) as `dcat:Catalog`'s (for both the core and extended profiles). 
* Revised mapping of element "Encoding", to use the value of attribute `@xlink:href`, if available, as the format URI.
* Fix to mapping of conformity degree.
* Included mapping for `gmd:explanation` (`earl:info`), concerning conformity test results.
* Updated parameters `MetadataUri` and `ResourceUri` based on the default rule, according to which HTTP URIs are specified for the metadata file identifier (metadata URI) and the resource identifier (resource URI).
* Moved "Lineage" and responsible organisations with role "originator" to the core profile, according with the revision to DCAT-AP.
* Fixed disalignment between the ISO 19115 maintenance frequency codes and the Dublin Core Collection Description Frequency Vocabulary.
* Added tentative mapping for ISO 19139 element "Spatial representation type". For this, `adms:representationTechnique` has been used for `dcat:Distribution`, and the spatial representation type codes in the original ISO 19139 record have been mapped to the corresponding URIs that may be made available through the INSPIRE Registry.
* Revised transformation of "Resource locator"'s based on the function code: 
    * `download` / `offlineAccess` / `order` -> `dcat:distribution` + `dcat:accessURL`.
    * `information` / `search` -> `foaf:page`.
    * `dcat:landingPage` when the function code is missing.
* Added URL for responsible organisations, when available. This has been modelled as follows:
    * with `foaf:workplaceHomepage`, when the responsible organisation has been modelled as a `foaf:Organization`.
    * with `vcard:hasURL`, when the responsible organisation has been modelled as a `vcard:Kind`. 
* Minor fixes.

## 2015-04-13: Revised version (v0.2)

* Fixed ambiguous rule in template "ResourceDates", causing processing warnings or errors.
* Values for resource format (encoding) and character encoding are no longer hard-coded, but taken from the relevant ISO 19139 elements. 
* Revised creation of distributions:
    * Added character encoding for metadata record and resource distributions (only for the extended profile).
    * Added distribution title (`gmd:transferOptions/*/gmd:onLine/*/gmd:name`).
    * Added distribution description (`gmd:transferOptions/*/gmd:onLine/*/gmd:description`).
    * Resource format (encoding), conditions for access and use, limitations on public access (only for the extended profile), is applied to each distribution (in ISO 19139, these are all associated with the resource, not with its distributions, as in DCAT/DCAT-AP).
* Fixed and revised specification of the resource language.
* Added tentative mapping for ISO 19139 element "Metadata file identifier". For this, `dct:identifier` has been used.
* Added tentative mappings for ISO 19139 elements "Metadata standard name" and "Metadata standard version". They have been modelled as characteristics of the source metadata record (`dct:source`), and specified by using `dct:conformsTo` + `dct:title` / `owl:versionInfo`.
* Added tentative mapping for ISO 19139 element "Maintenance information". For this, `dct:accrualPeriodicity` has been used, and the frequency codes in the original ISO 19139 record have been mapped to the corresponding ones of the of the [Dublin Core Collection Description Frequency Vocabulary](http://dublincore.org/groups/collections/frequency/) (when available).
* Fixed axis order in the coordinates of the bounding box.
* Revised generation of `earl:Assertion`'s to express conformity, based on whether the resource has or not a URI.
* Minor fixes.

## 2015-04-07: First version online (v0.1)

Preliminary version.