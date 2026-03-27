Logical: Pv1
Id: pv1
Parent: Base
Characteristics: #can-be-target
Title: "PV1 - Patient Visit"
Description:  """Modèle logique pour le segment PV1 dans le cadre de l'import de document Orbis"""

* pv12 1..1 code "Patient Class | Type de visite"
* pv12 from AphpTable0004 (required)
* pv13 0..1 Pl "Assigned Patient Location | Lieu de la visite"
* pv119 0..1 string "Visit Number | Identifiant de visite"
* pv144 0..1 string "Admit Date/Time | DateHeure d'admission, format : AAAAMMJJHHMMSS"