Logical: Msh
Id: msh
Parent: Base
Characteristics: #can-be-target
Title: "MSH - Message header"
Description:  """Modèle logique pour le segment MSH"""
 
* msh1 1..1 string "Field Separator | Séparateur"
* msh2 1..1 string "Encoding Characters | Caractères d'encodage"
* msh3 1..1 string "Sending Application | Application émettant le document"
* msh4 1..1 string "Sending Facility | Raison sociale de l'émétteur"
* msh5 1..1 string "Receiving Application | Application de réception"
* msh6 1..1 string "Receiving Facility | Raison sociale du récepteur"
* msh7 1..1 string "Date/Time Of Message | Date d'envoie du document par l'émetteur, format AAAAMMJJHHMMSS"
* msh9 1..1 code "Message Type | type de message"
* msh9 from MdmMessageTypeVs (required)
* msh10 1..1 string "Message Control Id | Identifiant du message"
* msh11 1..1 string "Processing Id | ?"
* msh12 1..1 string "Version ID | version du service"
* msh18 0..1 string "Character Set | Jeu de caractères"
