# Changelog

Unless specified otherwise, the entries in this changelog apply to file [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl).

## 2015-04-13: Revised version (v0.2)

* Fixed ambiguous rule in template "ResourceDates", causing processing warnings or errors.
* Values for resource format (encoding) and character encoding are no longer hard-coded, but taken from the relevant ISO 19139 elements. 
* Revised methodology for the creation of distributions:
    * Added character encoding for metadata record and resource distributions (only for the extended profile).
    * Added distribution title (`gmd:transferOptions/*/gmd:onLine/*/gmd:name`).
    * Added distribution description (`gmd:transferOptions/*/gmd:onLine/*/gmd:description`).
    * Resource format (encoding), conditions for access and use, limitations on public access (only for the extended profile), is applied to each distribution (in ISO 19139, these are all associated with the resource, not with its distributions, as in DCAT/DCAT-AP).
* Fixed and revised specification of the resource language.
* Added tentative mapping for ISO 19139 element "Metadata file identifier". For this, `dct:identifier` has been used.
* Added tentative mappings for ISO 19139 elements "Metadata standard name" and "Metadata standard version". They have been modelled as characteristics of the source metadata record (`dct:source`), and specified by using `dct:conformsTo` + `dct:title` / `owl:versionInfo`.
* Added tentative mapping for ISO 19139 element "Maintenance information". For this, `dct:accrualPeriodicity` has been used, and the frequency codes in the original ISO 19139 record have been mapped to the corresponding ones of the of the Dublin Core Collection Description Frequency Vocabulary (when available).
* Fixed axis order in the coordinates of the bounding box.
* Revised generation of `earl:Assertion`'s to express conformity, based on whether the resource has or not a URI.
* Minor fixes.

## 2015-04-07: First version online (v0.1)
