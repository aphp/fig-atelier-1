Instance: hl7-nullflavor-2-data-absent-reason
InstanceOf: ConceptMap
Title: "Mapping from HL7 v3 NullFlavor to FHIR Data Absent Reaso"
Description: "Extended ConceptMap between HL7 v3 NullFlavor codes and FHIR Data Absent Reason codes."
Usage: #definition

* name = "HL7NullFLavor2DataAbsentReason"
* experimental = false
* status = #active
* sourceCanonical = Canonical(http://terminology.hl7.org/ValueSet/v3-NullFlavor)
* targetCanonical = Canonical(http://hl7.org/fhir/ValueSet/data-absent-reason)
* group[0]
  * source = Canonical(http://terminology.hl7.org/CodeSystem/v3-NullFlavor)
  * target = Canonical(http://terminology.hl7.org/CodeSystem/data-absent-reason)
  * unmapped
    * mode = #fixed
    * code = #unknown
  * element[0]
    * code = #NI
    * display = "NoInformation"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #INV
    * display = "invalid"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #DER
    * display = "derived"   
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #OTH
    * display = "other"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #NINF
    * display = "negative infinity"
    * target[0]
      * code = #negative-infinity
      * display = "Negative Infinity (NINF)"
      * equivalence = #equivalent 
  * element[+]
    * code = #PINF
    * display = "positive infinity"
    * target[0]
      * code = #positive-infinity 
      * display = "Positive Infinity (PINF)"
      * equivalence = #equivalent 
  * element[+]
    * code = #UNC
    * display = "un-encoded"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #MSK
    * display = "masked"
    * target[0]
      * code = #masked
      * display = "Masked"
      * equivalence = #equivalent
  * element[+]
    * code = #NA
    * display = "not applicable"
    * target[0]
      * code = #not-applicable
      * display = "Not Applicable"
      * equivalence = #equivalent
  * element[+]
    * code = #UNK
    * display = "unknown"
    * target[0]
      * code = #unknown
      * display = "Unknown"
      * equivalence = #equivalent
  * element[+]
    * code = #ASKU
    * display = "asked but unknown"
    * target[0]
      * code = #asked-unknown
      * display = "Asked but unknown"
      * equivalence = #equivalent
  * element[+]
    * code = #NAV
    * display = "temporarily unavailable"
    * target[0]
      * code = #temp-unknown
      * display = "Temporarily Unknown"
      * equivalence = #relatedto
  * element[+]
    * code = #NASK
    * display = "not asked"
    * target[0]
      * code = #not-asked
      * display = "Not Asked"
      * equivalence = #equivalent
  * element[+]
    * code = #NAVU
    * display = "Not available"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #QS
    * display = "Sufficient Quantity"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #TRC
    * display = "trace"
    * target[0]
      * equivalence = #unmatched
  * element[+]
    * code = #NP
    * display = "not present"
    * target[0]
      * equivalence = #unmatched