Instance: xds-type-code-to-mediweb-document-type
InstanceOf: ConceptMap
Title: "Standardisation sémantique du type de document de FHIR vers HL7 v2"
Description: "ConceptMap produite dans le cadre du flux d'alimentation en document du DPI permettant de passer du DocumentReference.type au type de document de MDM."
Usage: #definition

* meta.profile[0] = $crmi-shareableconceptmap
* meta.profile[+] = $crmi-publishableconceptmap

// Pour être crmi compliant
* status = #draft
* name = "XdsTypeCodeToMediwebDocumentType"
* experimental = false
* date = "2026-01-20"

// définition des sources et des target
* sourceCanonical = "https://mos.esante.gouv.fr/NOS/JDV_J07-XdsTypeCode-CISIS/FHIR/JDV-J07-XdsTypeCode-CISIS"
* targetCanonical = Canonical(MediwebDocumentTypeVs)

* group[0]
  * source = "http://loinc.org"
  * target = Canonical(MediwebDocumentType)
  * element[0]
    * code = #85208-7
    * target[0]
      * code = #310
      * display = "Conclusions de téléconsultation"
      * equivalence = #equivalent
