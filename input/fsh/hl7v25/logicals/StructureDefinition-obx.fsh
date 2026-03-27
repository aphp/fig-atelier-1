Logical: Obx
Id: obx
Parent: Base
Characteristics: #can-be-target
Title: "OBX - Observation/Result Segment"
Description:  """Modèle logique pour le segment OBX dans le cadre de l'import de document Orbis"""

* obx1 1..1 string "Set ID- OBX | ?"
* obx2 1..1 code "Value type | type de valeur"
* obx5 1..1 Rp "Observation Value | Valeur de l'observation"
* obx11 1..1 string "Observation Result Status | statut de l'observation"
* obx11 from AphpTable0123 (required)