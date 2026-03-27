Logical: Pid
Id: pid
Parent: Base
Characteristics: #can-be-target
Title: "PID - Patient Identification"
Description:  """Modèle logique pour le segment PID dans le cadre de l'import de document Orbis"""

* pid3 1..* Cx "Patient Identifier List | Identifiants patient"
* pid5 1..* Xpn "Patient Name | Nom du patient"
* pid7 0..1 string "Date/Time of Birth | Date de naissance"
* pid8 0..1 code "Administrative Sex | Sexe administratif"
* pid8 from AphpTable0001 (required)
* pid18 0..1 string "Patient Account Number | Numéro du dossier administratif du patient"
