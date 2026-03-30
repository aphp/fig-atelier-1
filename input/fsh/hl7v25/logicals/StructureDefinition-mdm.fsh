Logical: Mdm
Id: mdm
Parent: Base
Characteristics: #can-be-target
Title: "MDM - full message"
Description:  """Modèle logique pour un message MDM"""

* msh 1..1 Msh "Message Header"
* evn 1..1 Evn "Event Type"
* pid 1..1 Pid "Patient Identification"
* pv1 1..1 Pv1 "Patient Visit"
* orc 1..1 Orc "Common order segment"
* obr 1..1 Obr "Observation request segment"
* txa 1..1 Txa "Document Notification"
* obx 0..1 Obx "Observation/Result"

Instance: mdm-t02
InstanceOf: Mdm
Title: "Exemple de message MDM^T02"
Description: "Exemple de message MDM^T02 (ajout d'un document)"
Usage: #example

* msh
  * msh1 = "|"
  * msh2 = "^~\\&"
  * msh3 = "Z0101"
  * msh4 = "026"
  * msh5 = "ORBIS"
  * msh6 = "APHP"
  * msh7 = "20260318105431"
  * msh9 = #MDM^T02
  * msh10 = "bc674253-3f97-4160-a614-ba1fc099b770"
  * msh11 = "P"
  * msh12 = "2.5"
  * msh18 = "8859/15"
* evn
  * evn2 = "20250128145310"
* pid
  * pid3
    * cx1 = "8034567890"
    * cx4 = "APHP"
    * cx5 = "PN"
  * pid5
    * xpn1 = "VINCENT"
    * xpn2 = "Michel"
    * xpn3 = "René"
  * pid7 = "20001020"
  * pid8 = #M
  * pid18 = "NDA"
* pv1
  * pv12 = #O
  * pv13
    * pl1 = "026X033"
    * pl11 = "SIRIUS"
  * pv119 = "NDA"
* orc
  * orc1 = #RE
  * orc2 = "Z0101_1"
  * orc13
    * pl4 = "026"
    * pl11 = "SIRIUS"
* obr
  * obr1 = "1"
  * obr2 = "Z0101_1"
  * obr25 = #F
* txa
  * txa1 = "1"
  * txa2 = #310
  * txa3 = "AP"
  * txa6 = "20250128144310"
  * txa12 = "Z0101_1"
  * txa17 = #AU
  *  txa22
    * ppn1 = "3213039"
    * ppn2 = "GRIFFON"
    * ppn3 = "Nicolas"
    * ppn9 = "APHP"
    * ppn15 = "20250128145310"
* obx
  * obx1 = "1"
  * obx2 = #RP
  * obx5
    * rp1 = "nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf"
    * rp2 = "libellé qui apparaît dans la colonne Description Orbis, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1"
  * obx11 = #F

Instance: mdm-t11
InstanceOf: Mdm
Usage: #example

* msh
  * msh1 = "|"
  * msh2 = "^~\\&"
  * msh3 = "Z0101"
  * msh4 = "026"
  * msh5 = "ORBIS"
  * msh6 = "APHP"
  * msh7 = "20260318112143"
  * msh9 = #MDM^T11
  * msh10 = "8727cd78-6446-4fe6-92f5-4e5c6ed6d7f5"
  * msh11 = "P"
  * msh12 = "2.5"
  * msh18 = "8859/15"
* evn
  * evn2 = "20250128145310"
* pid
  * pid3
    * cx1 = "8034567890"
    * cx4 = "APHP"
    * cx5 = "PN"
  * pid5
    * xpn1 = "VINCENT"
    * xpn2 = "Michel"
    * xpn3 = "René"
  * pid7 = "20001020"
  * pid8 = #M
  * pid18 = "NDA"
* pv1
  * pv12 = #O
  * pv13
    * pl1 = "026X033"
    * pl11 = "SIRIUS"
  * pv119 = "NDA"
* orc
  * orc1 = #RE
  * orc2 = "Z0101_1"
  * orc13
    * pl4 = "026"
    * pl11 = "SIRIUS"
* obr
  * obr1 = "1"
  * obr2 = "Z0101_1"
  * obr25 = #X
* txa
  * txa1 = "1"
  * txa2 = #310
  * txa3 = "AP"
  * txa6 = "20250128144310"
  * txa12 = "Z0101_1"
  * txa17 = #AU
  *  txa22
    * ppn1 = "3213039"
    * ppn2 = "GRIFFON"
    * ppn3 = "Nicolas"
    * ppn9 = "APHP"
    * ppn15 = "20250128145310"

Instance: mdm-t10
InstanceOf: Mdm
Usage: #example

* msh
  * msh1 = "|"
  * msh2 = "^~\\&"
  * msh3 = "Z0101"
  * msh4 = "026"
  * msh5 = "ORBIS"
  * msh6 = "APHP"
  * msh7 = "20260318143455"
  * msh9 = #MDM^T10
  * msh10 = "47f15c02-a6fe-4e2a-be7b-c06c1f5bc472"
  * msh11 = "P"
  * msh12 = "2.5"
  * msh18 = "8859/15"
* evn
  * evn2 = "20250128155310"
* pid
  * pid3
    * cx1 = "8034567890"
    * cx4 = "APHP"
    * cx5 = "PN"
  * pid5
    * xpn1 = "VINCENT"
    * xpn2 = "Michel"
  * pid7 = "20001020"
  * pid8 = #M
  * pid18 = "NDA"
* pv1
  * pv12 = #O
  * pv13
    * pl1 = "026X033"
    * pl11 = "SIRIUS"
  * pv119 = "NDA"
* orc
  * orc1 = #RE
  * orc2 = "Z0101_2"
  * orc13
    * pl4 = "026"
    * pl11 = "SIRIUS"
* obr
  * obr1 = "1"
  * obr2 = "Z0101_2"
  * obr25 = #F
* txa
  * txa1 = "1"
  * txa2 = #310
  * txa3 = "AP"
  * txa6 = "20250128154310"
  * txa12 = "Z0101_2"
  * txa13 = "Z0101_1"
  * txa17 = #AU
  *  txa22
    * ppn1 = "3213039"
    * ppn2 = "GRIFFON"
    * ppn3 = "Nicolas"
    * ppn9 = "APHP"
    * ppn15 = "20250128155310"
* obx
  * obx1 = "1"
  * obx2 = #RP
  * obx5
    * rp1 = "nomDeFluxEai.026.20250128-155310.Z0101_2.01.pdf"
    * rp2 = "libellé condensé lisible dans Orbis"
  * obx11 = #F
