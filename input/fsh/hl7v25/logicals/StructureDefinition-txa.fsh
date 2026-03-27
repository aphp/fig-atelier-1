Logical: Txa
Id: txa
Parent: Base
Characteristics: #can-be-target
Title: "TXA - Transcription Document Header Segment"
Description:  """Modèle logique pour le segment TXA dans le cadre de l'import de document Orbis"""

* txa1 1..1 string "Set ID- TXA"
* txa2 1..1 code "Document Type | Type de document"
* txa2 from MediwebDocumentTypeVs (required)
* txa3 0..1 string "Document Content Presentation"
* txa6 0..1 string "Origination Date/Time | DateHeure de création du document"
* txa9 0..* Xcn "Originator Code/Name | Auteur du document"
* txa12 1..1 string "Unique Document Number | Identifiant du document"
* txa13 0..1 string "Parent Document Number | Identifiant du document à modifier(/supprimer)"
* txa17 1..1 code "Document Completion Status"
* txa17 from AphpTable0271 (required)
* txa22 1..1 Ppn "Authentication Person, Time Stamp | Authenticator et horodatage"
