CodeSystem: MdmMessageType
Id: mdm-message-type
Title: "Type de message MDM"
Description: "Liste des types de message pour le flux d'alimentation en document d'Orbis"

* ^language = #fr-FR
* ^status = #active
* ^experimental = false
* ^content = #complete
* ^hierarchyMeaning = #grouped-by
* ^caseSensitive = true

* #MDM^T02 "Création du document (au statut validé)"
* #MDM^T10 "Modification du document (au statut validé)"
* #MDM^T11 "Annulation du document"
* #MDM^T04 "Modification du statut d'un document - passage du statut « créé » au statut « validé »"
* #MDM^T08 "Modification du contenu d’un document non validé"
