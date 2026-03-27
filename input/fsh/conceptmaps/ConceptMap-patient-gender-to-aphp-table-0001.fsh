Instance: patient-gender-to-aphp-table-0001
InstanceOf: ConceptMap
Title: "Standardisation sémantique du sexe administratif de FHIR vers HL7 v2"
Description: "ConceptMap produite dans le cadre du flux d'alimentation en document du DPI permettant de passer du Patient.gender au Sexe administratif de MDM."
Usage: #definition

* meta
  * profile[0] = $crmi-shareableconceptmap
  * profile[+] = $crmi-publishableconceptmap

// Pour être crmi compliant
* status = #active
* name = "PatientGenderToAphpTable0001"
* experimental = false
* date = "2026-01-20"

// définition des sources et des target
* sourceCanonical = "http://hl7.org/fhir/ValueSet/administrative-gender"
* targetCanonical = Canonical(AphpTable0001)

* group[0]
  * source = "http://hl7.org/fhir/administrative-gender"
  * target = "http://terminology.hl7.org/CodeSystem/v2-0001"
  * unmapped
    * mode = #fixed
    * code = #U
  * element[0]
    * code = #male
    * display = "Male"
    * target[0]
      * code = #M
      * display = "Male"
      * equivalence = #equivalent
  * element[+]
    * code = #female
    * display = "Female"
    * target[0]
      * code = #F
      * display = "Female"
      * equivalence = #equivalent
  * element[+]
    * code = #other
    * display = "Other"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #unknown
    * display = "Unknown"
    * target[0]
      * equivalence = #unmatched
