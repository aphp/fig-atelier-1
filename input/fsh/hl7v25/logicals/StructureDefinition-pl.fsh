Logical: Pl
Id: pl
Parent: Base
Characteristics: #can-be-target
Title: "PL - person location"
Description:  """Modèle logique pour le datatype PL dans le cadre de l'import de document Orbis"""


* pl1 0..1 string "Point of Care | unité de soins"
* pl4 0..1 string "Facility | Etablissement"
* pl10 0..1 Ei "Comprehensive Location Identifier | Identifiant de localisation"
* pl11 0..1 string "Assigning Authority for Location | Authorité d'identification de la localisation"
