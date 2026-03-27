Logical: Orc
Id: orc
Parent: Base
Characteristics: #can-be-target
Title: "ORC - Common Order Segment"
Description:  """Modèle logique pour le segment ORC dans le cadre de l'import de document Orbis"""

* orc1 1..1 code "Order Control | ?"
* orc2 1..1 string "Placer Order Number | Identifiant du document"
* orc13 0..1 Pl "Enterer's Location | Localisation du demandeur"
