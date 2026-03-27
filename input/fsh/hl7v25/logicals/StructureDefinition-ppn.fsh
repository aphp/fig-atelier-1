Logical: Ppn
Id: ppn
Parent: Base
Characteristics: #can-be-target
Title: "PPN - performing person time stamp"
Description:  """Modèle logique pour le datatype PPN dans le cadre de l'import de document Orbis"""

* ppn1 1..1 string "ID Number | Identifiant du professionnel"
* ppn2 1..1 string "Family Name | Nom du professionnel"
* ppn3 1..1 string "Given Name | Prénom du professionnel"
* ppn9 0..1 string "Assigning authority | Authorité d'identification"
* ppn15 1..1 string "Date/Time Action Performed | Date/Heure de validation du document, au format AAAAMMJJHHMMSS"
