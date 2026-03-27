Logical: Xpn
Id: xpn
Parent: Base
Characteristics: #can-be-target
Title: "XPN - extended person name"
Description:  """Modèle logique pour le datatype XPN dans le cadre de l'import de document Orbis"""

* xpn1 0..1 string "Family Name | Nom de famille"
* xpn2 0..1 string "Given Name | Prénom"
* xpn3 0..1 string "Second and Further Given Names or Initials Thereof | Deuxièmes prénoms et plus"
* xpn4 0..1 string "Suffix (e.g., JR or III) | Suffixe"
* xpn5 0..1 string "Prefix (e.g., DR) | Préfixe"
* xpn6 0..1 string "Degree (e.g., MD) | Diplôme"
* xpn7 0..1 code "Name Type Code | Type de nom"
* xpn7 from AphpTable0200 (required)

