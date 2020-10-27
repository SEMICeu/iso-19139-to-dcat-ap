# Changelog

Unless specified otherwise, the entries in this changelog apply to file [`iso-19139-to-dcat-ap.xsl`](./iso-19139-to-dcat-ap.xsl).

## 2020-06-22: New version (v2.0)

This version includes revisions needed to ensure compliance with DCAT 2 and DCAT-AP 2.0, and reflecting the first working draft of GeoDCAT-AP 2.0.0:

https://semiceu.github.io/GeoDCAT-AP/drafts/2.0.0-draft-0.1/

Such revisions are implemented in a conservative way - i.e., by adding new mappings without removing the original ones, but flagging them as deprecated, thus ensuring backward compatibility. 

Another main change concerns having moved to the core profile some mappings which were originally part of the extended profile only, and concerning metadata elements supported in DCAT-AP 2.

Finally, this new version includes revisions to ensure compliance with the 2017 edition of the INSPIRE Metadata Implementation Guidelines. Also in this case, revisions have been implemented in a conservative way, to ensure backward compatibility with metadata records following previous versions of the INSPIRE Metadata Technical Guidelines.

More precisely:

* Updated licence version, attribution, and links.
* Switched to DCAT-AP and GeoDCAT-AP namespace URIs to denote, respectively, the core and extended GeoDCAT-AP profile. Backward compatibility with the previous versions is ensured, where codes "core" and "extended" were used instead.
* Added mappings for new classes and properties included in DCAT-AP 2:
    * `dcat:DataService`.
    * `dcat:endpointURL`.
    * `dcat:endpointDescription`.
    * `dcat:accessService`.
    * `dcat:servesDataset`.
    * `dcat:bbox`.
    * `dcat:startDate`.
    * `dcat:endDate`.
    * `dcat:spatialResolutionInMeters`
    * `dcat:hadRole`.
* Added mappings for properties with a broader domain in DCAT-AP 2:
    * `dcat:theme`.
    * `dcat:keyword`.
    * `dcat:contactPoint`.
* Moved to core profile mappings originally supported only in the extended profile:
    * Resource type "service".
    * Resource types.
    * Service types.
    * Constraints related to access and use for services.
    * Conformity (only in case the resource is conformant).
    * Metadata standard.
    * Responsible party role "author".
    * Spatial resolution.
    * Spatial reference system.
* Mappings revised and added to ensure compliance with the 2017 edition of the INSPIRE Metadata Technical Guidelines:
    * Revised and added mappings for conditions for limitations on public access and conditions for access and use. In particular, element `gmd:useConstraints` is now used to map use conditions. The previous versions of the mappings used instead element `gmd:useLimitation`, which has been kept for backward compatibility, but flagged as deprecated.
* Enhancements:
    * Added checks for empty elements.
    * Revised mapping for reference systems, to include also values specified via `gmx:Anchor`.
    * Revised mapping for spatial resolution, to extend detection of unit of measurements.
    * Revised mapping for constraints on access and use, to include also values specified via `gmd:MD_RestrictionCode` and `gmx:Anchor`.
    * Revised mapping for distributions, to include reference to the relevant service / API via `dcat:accessService`. One major difference with respect to the previous versions of the mapping is that resource locators are considered as distributions of datasets and series whenever they point to a service / API.
    * Revised mapping for time literals, to detect their data type.
    * Revised mapping for temporal extent, to core with the use of versioned `gml:` namespaces.

## 2016-11-28: Revised version (v1.13)
* Added mappings for multilingual elements. More precisely, these mappings concern the following elements:
    * Metadata standard name.
    * Resource title, abstract, and lineage.
    * Free-text keywords, keyword from controlled vocabularies, and name of originating controlled vocabularies.
    * Constraints related to access and use.
    * Individual / organisation name of responsible parties.
    * Title and description of resource locators.
    * Title of specifications referred to from conformity test results.
    * Explanation of conformity test results.
* Fixed bug concerning the mappings for resource types.
* Fixed bugs concerning the mappings for responsible parties.
* Fixed bug concerning the mappings for postal addresses.

## 2016-07-09: Revised version (v1.12)
* Extended mapping of responsible parties, to (a) detect URIs for individuals and organisations, specified by using `gmx:Anchor/@xlink:href`, and (b) include additional information present in the original record - in particular, individual name, telephone, and address.
* Fixed bug concerning the mapping of malformed URNs for reference systems, returning an empty string for SRID. Dropped trailing slash in the URIs of the EPSG and OGC CRS registers, and added parameters for the names of these registers.
* Editorial changes.

## 2016-03-14: Revised version (v1.11)
* Revised mapping of keywords: Even if the originating controlled vocabulary is not specified, keywords specified with HTTP URIs via `gmx:Anchor/@xlink:href`, are mapped to `dcat:theme`.

## 2016-01-26: Revised version (v1.10)
* Added variables storing the IDs of the GeoDCAT-AP core and extended profiles. These variables are now used instead of the actual IDs in the XSLT, whenever checks are made to identify the selected profile.
* Revised handling of coupled resources:
    * Added global parameter `$CoupledResourceLookUp` to enable / disable coupled resources' lookup.
    * Coupled resources are looked up when (a) parameter `$CoupledResourceLookUp` is set to `enabled` and (b) the value of the `@xlink:href` attribute starts with `http://` or `https://`.
* Updated copyright year, and added contributors.

## 2016-01-11: Revised version (v1.9)
* Revised mapping of coupled resources, as per GeoDCAT-AP 1.0:
    * Coupled resources are referred to by using their resource identifier, retrieved at runtime from the metadata record linked from `srv:operatesOn/@xlink:href`.
    * When this attribute is not specified, the XSLT verifies is the relevant part of the `gmd:MD_Identification` section is specified as child of `srv:operatesOn`.
    * Otherwise, the value of attribute `srv:operatesOn/@uuidref` is used, if available.
    * The mapping takes also into account the coupled resource URI possibly specified with attribute `srv:operatesOn/@:uriref`. This option might be revised in the future, based on the new version of the INSPIRE Metadata Technical Guidelines.
* Relaxed the identification of metadata and resource languages, by considering also when specified by using `gmd:language/gco:CharacterString`.
* Revised mapping of responsible party roles 'author' and 'originator', as per GeoDCAT-AP 1.0. Role 'author' is now mapped to `dct:creator`; role 'originator', originally mapped to `dct:creator`, is modelled only by using the PROV-based mapping.

## 2015-12-28: Revised version (v1.8)
* Fixed bug concerning the mapping of white spaces in URLs into their %-escaped encoding.
* Made the Unique Resource Identifier more generic, to match both `gmd:MD_Identifier` and `gmd:RS_identifier`.
* Moved coordinate and reference systems mappings to the extended profile only.

## 2015-10-26: Revised version (v1.7)
* Mapping of coupled resources tentatively revised, taking into account the use of the `@uriref` and `@xlink:href` attributes.
* OGC's URNs for spatial reference systems are mapped to the corresponding HTTP URIs.
* Added `dct:type` to denote a spatial reference system.

## 2015-10-09: Revised version (v1.6)
* Added missing mapping for language codes.
* Created parameters for bounding box coordinates, to be used in the supported geometry encodings.

## 2015-10-06: Revised version (v1.5)
* Fixed bug concerning metadata on metadata. The corresponding RDF snippet was generated irrespective of whether this information was included or not in the original metadata record.
* Fixed bug concerning lineage. The corresponding RDF snippet was generated irrespective of whether this information was included or not in the original metadata record.

## 2015-09-03: Revised version (v1.4)
* Fixed bug concerning resource type. The XSLT wrongly fetched the scope code from the data quality element, instead of the one specified in the hierarchy level element.

## 2015-08-30: Revised version (v1.3)
* Removed unused namespaces.

## 2015-08-24: Revised version (v1.2)
* Fixed bug concerning constraints related to access and use, when a URI/URL is not provided. The XSLT wrongly selected the content of `gmx:Anchor` instead of `gco:CharacterString`.

## 2015-07-29: Revised version (v1.1)
* Fixed bug concerning the mapping of "conformance results" (only for the extended profile). The bug caused the possible creation of multiple instance of class `prov:Activity` as objects of the same instance of property `prov:wasUsedBy`.

## 2015-07-13: First stable version (v1.0)
* Version implementing the draft of the GeoDCAT-AP specification released for public review.

## 2015-07-08: Revised version (v0.6.3)
* Update frequency: replaced mappings from the relevant ISO code list to the Dublin Core frequency vocabulary with mappings to the [MDR Frequency NAL](http://publications.europa.eu/mdr/authority/frequency/), as per the current DCAT-AP specification.

## 2015-06-03: Revised version (v0.6.2)
* Minor fixes.
* Format: name now omitted when the format is specified with an HTTP URI.
* Metadata standard: name and version are now omitted when the standard is specified with an HTTP URI.
* Conformity specification: when specified with an HTTP URI, title and date are now omitted.

## 2015-05-26: Revised version (v0.6.1)
* Minor fixes and revisions.
* Replaced `rdfs:label` with `dct:title` for the name of a controlled vocabulary (`skos:ConceptScheme`).
* Replaced `dcat:dataset` with `dct:hasPart` to model coupled resources (only for the extended profile).
* Added ISO 19115 code list for maintenance frequency. The URI is tentative, since that code list is not yet available via the INSPIRE Registry.
* Updated URI for spatial representation type code list.

## 2015-05-25: Revised version (v0.6)
* Minor fixes and revisions.
* Revised mapping for keywords when used for services (only for the extended profile): `dct:subject` and `dc:subject` are used instead of `dcat:theme` and `dcat:keyword`.
* Revised mapping for "use limitations". It always maps to `dct:license`, and the free text description is omitted when an HTTP URI is provided via `gmx:Anchor/@xlink:href`.
* Revised mapping of keywords from controlled vocabularies: if the keyword is denoted by an HTTP URI, the information on the originating controlled vocabulary is not included in the mapping. The motivation is that this information can be obtained by accessing the keyword URI.
* Added mapping for spatial resolution, by using `rdfs:comment` with a human-readable presentation of distance or equivalent scale. This includes mappings from EPSG codes / OGC URNs to UCUM codes (for units of measure).
* Revised mapping of geographic identifier, based on whether the geographic identifier is or not an HTTP URI.
* Revised mapping for conformance result, based on the W3C PROV ontology (only for the extended profile).
* Added mapping for spatial and temporal reference systems, by using `dct:conformsTo` (only for the extended profile). The representation of the reference system varies depending on whether it is specified with an HTTP URI (`@rdf:resource`), a URN (`dct:identifier`), or as free text (`skos:prefLabel`). The code space is modelled as a `skos:ConceptScheme` and the version as `owl:versionInfo`.

## 2015-05-18: Revised version (v0.5)
* Minor fixes.
* When a URL is available in `gmd:useLimitations`, `dct:license` + `dct:LicenseDocument` are used, instead of `dct:rights` + `dct:RightsStatement`.
* Added mapping for geographic identifier and extent description (spatial coverage). The geographic identifier is modelled as a `skos:Concept`, the code is specified with `skos:prefLabel`, the authority is modelled as a `skos:ConceptScheme`. If the code is associated with an HTTP URI by using `gmx:Anchor/@xlink:href`, this will be used as the URI of the geographic identifier (`skos:Concept`).
* Revised generation of bounding box encodings wrt axis order. The default spatial reference system (SRS) is now CRS84 (and not EPSG:4326). Consequently, the default axis order is now longitude / latitude for both WKT and GML (in GeoJSON, the axis order is always longitude / latitude irrespective of the SRS used). If a different SRS is used, the axis order must be explicitly specified by using a specific parameter (`$SrsAxisOrder`).

## 2015-05-12: Revised version (v0.4)
* Core and extended profiles revised to match with the current version of the DCAT-AP specification.
* Metadata and resource character encodings: ISO 19115 character set codes have been mapped to the IANA character set names.
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
