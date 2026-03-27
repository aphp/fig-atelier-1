Logical: Obr
Id: obr
Parent: Base
Characteristics: #can-be-target
Title: "OBR - Observation Request Segment"
Description:  """Modèle logique pour le segment OBR dans le cadre de l'import de document Orbis"""

* obr1 1..1 string "Set ID - OBR | ?"
* obr2 1..1 string "Placer Order Number | ?"
* obr25 0..1 code "Result status + | statut du document"
* obr25 from AphpTable0123 (required)