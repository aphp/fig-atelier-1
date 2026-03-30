La transformation d'une ressource FHIR `DocumentReference`, issue d'un [DMN](https://interop.aphp.fr/ig/fhir/tls/glossary.html#dmn){: target="_blank"}, en un message HL7v2 de création de document `MDM^T02` est décrite par [DocumentReferenceToT02](StructureMap-DocumentReferenceToT02.html).

La validation de cette [StructureMap](StructureMap-DocumentReferenceToT02.html), appliquée à l'[exemple de document FHIR](DocumentReference-ajout.html), produit [un message HL7 v2 T02](Binary-mdm-t02.html) conforme au *modèle logique* [mdm](StructureDefinition-mdm.html).

### Segment MSH

🔖 **Champ MSH-1**

La valeur de ce champ est fixée à `|`

Cible :

```
MSH|
```

🔖 **Champ MSH-2**

La valeur de ce champ est fixée à `^~\&`

Cible :

```
MSH|^~\&
```

🔖 **Champ MSH-3**

Source, on s'intéresse à l'élément `custodian.identifier.value` :

{% fragment DocumentReference/ajout JSON EXCEPT:custodian %}

Cible :

```
MSH|^~\&|2444555666
```

🔖 **Champ MSH-4**

Source, on s'intéresse à l'élément `author:serviceRespMed.identifier.value`, et plus spécifiquement aux trois premiers caractères qui identifient un établissement de l'AP-HP dans le DPI :

{% fragment DocumentReference/ajout JSON EXCEPT:author %}

Cible :

```
MSH|^~\&|2444555666|026
```

🔖 **Champ MSH-5**

La valeur de ce champ est fixée à `DPI`

Cible :

```
MSH|^~\&|2444555666|026|DPI
```

🔖 **Champ MSH-6**

La valeur de ce champ est fixée à `APHP`

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP
```

🔖 **Champ MSH-7**

Ce champ contient la date d'exécution de la transformation (au format YYYYMMDDHHMMSS).

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831
```

🔖 **Champ MSH-9**

La valeur de ce champ est fixée à `MDM^T02`

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02
```

🔖 **Champ MSH-10**

Ce champ contient un identifiant unique de message HL7 v2 pour le BPE, en l'occurrence un UUID.

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770
```

🔖 **Champ MSH-11**

La valeur de ce champ est fixée à `P` (_Production_)

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770|P
```

🔖 **Champ MSH-12**

La valeur de ce champ est fixée à `2.5`

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770|P|2.5
```

🔖 **Champ MSH-18**

La valeur de ce champ est fixée à `8859/15`

Cible :

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770|P|2.5||||||8859/15
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:custodian|author EXCEPT:system|value BASE:author.identifier EXCEPT:system|value BASE:custodian.identifier %}

🔖 **Modèle logique**

```json
{
  "msh1": "|",
  "msh2": "^~\\&",
  "msh3": "2444555666",
  "msh4": "026",
  "msh5": "DPI",
  "msh6": "APHP",
  "msh7": "20260325135831",
  "msh9": "MDM^T02",
  "msh10": "bc674253-3f97-4160-a614-ba1fc099b770",
  "msh11": "P",
  "msh12": "2.5",
  "msh18": "8859/15"
}
```

🔖 **HL7 v2**

```
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770|P|2.5||||||8859/15
```

### Segment EVN

🔖 **Champ EVN-2**

Le champ EVN-2 contient la date de validation du document, portée par l'élément `content.attachment.creation`, au format YYYYMMDDHHMMSS :

{% fragment DocumentReference/ajout JSON EXCEPT:content EXCEPT:creation BASE:content.attachment %}

Cible :

```
EVN||20250128145310
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:content EXCEPT:creation BASE:content.attachment %}

🔖 **Modèle logique**

```json
{
  "evn2": "20250128145310"
}
```

🔖 **HL7 v2**

```
EVN||20250128145310
```

### Segment PID

🔖 **Champ PID-3** <a id="ipp"/>

Le champ PID-3 contient l'identifiant du patient au sein de l'AP-HP (son IPP). Les champs PID-3.4 et PID-3.5 sont fixés, respectivement, à `APHP` et `PN`. La valeur du champ PID-3.1 correspond à l'IPP du patient proprement dit. On retrouve cet IPP dans la ressource `Patient` `contained` référencée par l'élément `DocumentReference.subject`. Plus spécifiquement, on s'intéresse à l'élément `Patient.identifier:pi.value` :

{% fragment DocumentReference/ajout JSON EXCEPT:subject|contained.where($this is Patient) EXCEPT:id|identifier BASE:contained %}

Cible, on s'intéresse notamment au champ PID-3.1 :

```
PID|||8034567890^^^APHP^PN
```

🔖 **Champ PID-5**

Le champ PID-5.1 contient le nom de famille, le champ PID-5.2 contient le premier prénom et le champ PID-5.3 contient les autres prénoms. On retrouve ces informations dans l'élément `Patient.name` :

{% fragment DocumentReference/ajout JSON EXCEPT:subject|contained.where($this is Patient) EXCEPT:id|name BASE:contained %}

Cible :

```
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René
```

🔖 **Champ PID-7**

Ce champ contient la date de naissance (format YYYYMMDD) du patient. Cette information est issue de l'élément `Patient.birthDate` :

{% fragment DocumentReference/ajout JSON EXCEPT:subject|contained.where($this is Patient) EXCEPT:id|birthDate BASE:contained %}

Cible :

```
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René||20001020
```

🔖 **Champ PID-8**

Ce champ contient le sexe du patient (M ou F). Cette information est issue de l'élément `Patient.gender`. Une transcodification est nécessaire, portée par la ConceptMap [de Standardisation sémantique du sexe administratif de FHIR vers HL7 v2](ConceptMap-patient-gender-to-aphp-table-0001.html) :

{% fragment DocumentReference/ajout JSON EXCEPT:subject|contained.where($this is Patient) EXCEPT:id|gender BASE:contained %}

Cible :

```
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René||20001020|M
```

🔖 **Champ PID-18**

Ce champ contient le NDA correspondant au dossier de consultation du patient dans l'unité concernée. Cette information **n**'est **pas** disponible dans la requête d'ajout et **DOIT** être inférée via un script du CSA à partir de [l'IPP](#ipp) et de [l'UF](#uf).

Cible :

```
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René||20001020|M||||||||||NDA
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:subject|contained.where($this is Patient) EXCEPT:id|identifier|name|gender|birthDate BASE:contained EXCEPT:system|value BASE:contained.identifier %}

🔖 **Modèle logique**

```json
{
  "pid3": [
    {
      "cx1": "8034567890",
      "cx4": "APHP",
      "cx5": "PN"
    }
  ],
  "pid5": [
    {
      "xpn1": "VINCENT",
      "xpn2": "Michel",
      "xpn3": "René"
    }
  ],
  "pid7": "20001020",
  "pid8": "M",
  "pid18": "NDA"
}
```

🔖 **HL7 v2**

```
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René||20001020|M||||||||||NDA
```

### Segment PV1

🔖 **Champ PV1-2**

La télésurveillance est traitée comme de l'externe ; la valeur de ce champ est donc fixée à `O` (_Outpatient_).

Cible :

```
PV1||O
```

🔖 **Champ PV1-3** <a id="uf"/>

Le champ PV1-3.1 contient l'unité de consultation ; cette information est fournie par l'élément `author:serviceRespMed.identifier.value`. La valeur du champ PV1-3.11 est fixée à `SIRIUS` :

{% fragment DocumentReference/ajout JSON EXCEPT:author %}

Cible :

```
PV1||O|026X033^^^^^^^^^^SIRIUS
```

🔖 **Champ PV1-19**

Ce champ contient le NDA correspondant au dossier de consultation du patient dans l'unité concernée. Cette information **n**'est **pas** disponible dans la requête d'ajout et **DOIT** être inférée via un script du CSA à partir de [l'IPP](#ipp) et de [l'UF](#uf).

Cible :

```
PV1||O|026X033^^^^^^^^^^SIRIUS||||||||||||||||NDA
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:author EXCEPT:system|value BASE:author.identifier %}

🔖 **Modèle logique**

```json
{
  "pv12": "O",
  "pv13": {
    "pl1": "026X033",
    "pl11": "SIRIUS"
  },
  "pv119": "NDA"
}
```

🔖 **HL7 v2**

```
PV1||O|026X033^^^^^^^^^^SIRIUS||||||||||||||||NDA
```

### Segment ORC

🔖 **Champ ORC-1**

La valeur de ce champ est fixée à `RE`

Cible :

```
ORC|RE|
```

🔖 **Champ ORC-2** <a id="orc2"/>

Le champ ORC-2 contient les 5 derniers caractères du namespace du masterIdentifier du document à créer (ces 5 caractères correspondent au code Hopex du DMN) et la valeur de ce masterIdentifier, séparés par un `_` :

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier %}

Cible :

```
ORC|RE|Z0101_1
```

🔖 **Champ ORC-13**

Le champ ORC-13.4 contient l'établissement. Cette information est fournie par l'élément `author:serviceRespMed.identifier.value`, plus spécifiquement par les trois premiers caractères. La valeur du champ ORC-13.11 est fixée à `SIRIUS` :

{% fragment DocumentReference/ajout JSON EXCEPT:author %}

Cible :

```
ORC|RE|Z0101_1|||||||||||^^^026^^^^^^^SIRIUS
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier|author EXCEPT:system|value BASE:author.identifier %}

🔖 **Modèle logique**

```json
{
  "orc1": "RE",
  "orc2": "Z0101_1",
  "orc13": {
    "pl4": "026",
    "pl11": "SIRIUS"
  }
}
```

🔖 **HL7 v2**

```
ORC|RE|Z0101_1|||||||||||^^^026^^^^^^^SIRIUS
```

### Segment OBR

🔖 **Champ OBR-1**

La valeur de ce champ est fixée à `1`

Cible :

```
OBR|1|
```

🔖 **Champ OBR-2**

Ce champ contient la même valeur que le champ [ORC-2](#orc2) : les 5 derniers caractères du namespace du masterIdentifier du document à créer (ces 5 caractères correspondent au code Hopex du DMN) et la valeur de ce masterIdentifier, séparés par un `_` :

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier %}

Cible :

```
OBR|1|Z0101_1
```

🔖 **Champ OBR-25**

La valeur de ce champ est fixée à `F` (_Finalized_)

Cible :

```
OBR|1|Z0101_1|||||||||||||||||||||||F
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier %}

🔖 **Modèle logique**

```json
{
  "obr1": "1",
  "obr2": "Z0101_1",
  "obr25": "F"
}
```

🔖 **HL7 v2**

```
OBR|1|Z0101_1|||||||||||||||||||||||F
```

### Segment TXA

🔖 **Champ TXA-1**

La valeur de ce champ est fixée à `1`

Cible :

```
TXA|1
```

🔖 **Champ TXA-2**

Ce champ contient le type de document. Une transcodification est nécessaire pour passer du type fourni par l'élément `DocumentReference.type` au type attendu par le DPI. C'est l'objet de la ConceptMap [de Standardisation sémantique du type de document de FHIR vers HL7 v2](ConceptMap-xds-type-code-to-mediweb-document-type.html) :

{% fragment DocumentReference/ajout JSON EXCEPT:type %}

Cible :

```
TXA|1|310
```

🔖 **Champ TXA-3**

La valeur de ce champ est fixée à `AP`.

Cible :

```
TXA|1|310|AP
```

🔖 **Champ TXA-6**

Ce champ contient la date de création de la ressource DocumentReference, provenant de l'élément `DocumentReference.date`, au format YYYYMMDDHHMMSS :

{% fragment DocumentReference/ajout JSON EXCEPT:date %}

Cible :

```
TXA|1|310|AP|||20250128144310
```

🔖 **Champ TXA-12**

Ce champ contient la même valeur que le champ [ORC-2](#orc2) : les 5 derniers caractères du namespace du masterIdentifier du document à créer (ces 5 caractères correspondent au code Hopex du DMN) et la valeur de ce masterIdentifier, séparés par un `_` :

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier %}

Cible :

```
TXA|1|310|AP|||20250128144310||||||Z0101_1
```

🔖 **Champ TXA-17**

La valeur de ce champ est fixée à `AU`

Cible :

```
TXA|1|310|AP|||20250128144310||||||Z0101_1|||||AU
```

🔖 **Champs TXA-22.1, 22.2, 22.3 et 22.9**

Ces champs contiennent les informations d'identification du professionnel ayant validé le document. Elles sont fournies dans la ressource `Practitioner` `contained` pointée par l'élément `Practitioner` de la ressource `PractitionerRole` `contained` pointée par l'élément `authenticator` du `DocumentReference` fourni avec la requête :

{% fragment DocumentReference/ajout JSON EXCEPT:authenticator|contained.where($this is PractitionerRole)|contained.where($this is Practitioner) EXCEPT:id|practitioner|name|identifier BASE:contained %}

Cible :

```
TXA|1|310|AP|||20250128144310||||||Z0101_1|||||AU|||||3213039^GRIFFON^Nicolas^^^^^^APHP
```

🔖 **Champ TXA-22.15**

Ce champ contient la date de validation du document, portée par l'élément `content.attachment.creation` :

{% fragment DocumentReference/ajout JSON EXCEPT:content EXCEPT:creation BASE:content.attachment %}

Cible :

```
TXA|1|310|AP|||20250128144310||||||Z0101_1|||||AU|||||3213039^GRIFFON^Nicolas^^^^^^APHP^^^^^^20250128145310
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:type|date|masterIdentifier|content|contained.where($this is PractitionerRole)|contained.where($this is Practitioner) EXCEPT:creation BASE:content.attachment EXCEPT:id|practitioner|name|identifier BASE:contained EXCEPT:system|value BASE:contained.identifier %}

🔖 **Modèle logique**

```json
{
  "txa1": "1",
  "txa2": "310",
  "txa3": "AP",
  "txa6": "20250128144310",
  "txa12": "Z0101_1",
  "txa17": "AU",
  "txa22": {
    "ppn1": "3213039",
    "ppn2": "GRIFFON",
    "ppn3": "Nicolas",
    "ppn9": "APHP",
    "ppn15": "20250128145310"
  }
}
```

🔖 **HL7 v2**

```
TXA|1|310|AP|||20250128144310||||||Z0101_1|||||AU|||||3213039^GRIFFON^Nicolas^^^^^^APHP^^^^^^20250128145310
```

### Segment OBX

🔖 **Champ OBX-1**

La valeur de ce champ est fixée à `1`

Cible :

```
OBX|1
```

🔖 **Champ OBX-2**

La valeur de ce champ est fixée à `RP` (_Reference Pointer_)

Cible :

```
OBX|1|RP
```

🔖 **Champ OBX-5**

Le champ OBX-5.1 contient le nom du fichier, déduit des éléments contenus dans le DocumentReference et de la convention de nommage. Le champ OBX-5.2 contient le titre du fichier, porté par l'élément `content.attachment.title` :

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier|content|author EXCEPT:system|value BASE:author.identifier EXCEPT:title|creation BASE:content.attachment %}

Cible :

```
OBX|1|RP|||nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf^libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1
```

🔖 **Champ OBX-11**

La valeur de ce champ est fixée à `F`

Cible :

```
OBX|1|RP|||nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf^libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1||||||F
```

🔖 **Segment complet**

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON EXCEPT:masterIdentifier|author|content EXCEPT:title|creation BASE:content.attachment EXCEPT:system|value BASE:author.identifier %}

🔖 **Modèle logique**

```json
{
  "obx1": "1",
  "obx2": "RP",
  "obx5": {
    "rp1": "nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf",
    "rp2": "libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1"
  },
  "obx11": "F"
}
```

🔖 **HL7 v2**

```
OBX|1|RP|||nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf^libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1||||||F
```

### Transformation complète

🔖 **Source FHIR (DocumentReference)**

{% fragment DocumentReference/ajout JSON ELIDE:contained.identifier.type|author.identifier.type|author.display|author.type EXCEPT:contained|masterIdentifier|author|content EXCEPT:title|creation BASE:content.attachment %}

🔖 **Modèle logique**

```json
{
  "resourceType": "https://interop.aphp.fr/ig/fhir/endor/StructureDefinition/mdm",
  "msh": {
    "msh1": "|",
    "msh2": "^~\\&",
    "msh3": "2444555666",
    "msh4": "026",
    "msh5": "DPI",
    "msh6": "APHP",
    "msh7": "20260318105431",
    "msh9": "MDM^T02",
    "msh10": "bc674253-3f97-4160-a614-ba1fc099b770",
    "msh11": "P",
    "msh12": "2.5",
    "msh18": "8859/15"
  },
  "evn": {
    "evn2": "20250128145310"
  },
  "pid": {
    "pid3": [
      {
        "cx1": "8034567890",
        "cx4": "APHP",
        "cx5": "PN"
      }
    ],
    "pid5": [
      {
        "xpn1": "VINCENT",
        "xpn2": "Michel",
        "xpn3": "René"
      }
    ],
    "pid7": "20001020",
    "pid8": "M",
    "pid18": "NDA"
  },
  "pv1": {
    "pv12": "O",
    "pv13": {
      "pl1": "026X033",
      "pl11": "SIRIUS"
    },
    "pv119": "NDA"
  },
  "orc": {
    "orc1": "RE",
    "orc2": "Z0101_1",
    "orc13": {
      "pl4": "026",
      "pl11": "SIRIUS"
    }
  },
  "obr": {
    "obr1": "1",
    "obr2": "Z0101_1",
    "obr25": "F"
  },
  "txa": {
    "txa1": "1",
    "txa2": "310",
    "txa3": "AP",
    "txa6": "20250128144310",
    "txa12": "Z0101_1",
    "txa17": "AU",
    "txa22": {
      "ppn1": "3213039",
      "ppn2": "GRIFFON",
      "ppn3": "Nicolas",
      "ppn9": "APHP",
      "ppn15": "20250128145310"
    }
  },
  "obx": {
    "obx1": "1",
    "obx2": "RP",
    "obx5": {
      "rp1": "nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf",
      "rp2": "libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1"
    },
    "obx11": "F"
  }
}
```

🔖 **HL7 v2**

```text
MSH|^~\&|2444555666|026|DPI|APHP|20260325135831||MDM^T02|bc674253-3f97-4160-a614-ba1fc099b770|P|2.5||||||8859/15
EVN||20250128145310
PID|||8034567890^^^APHP^PN||VINCENT^Michel^René||20001020|M||||||||||NDA
PV1||O|026X033^^^^^^^^^^SIRIUS||||||||||||||||NDA
ORC|RE|Z0101_1|||||||||||^^^026^^^^^^^SIRIUS
OBR|1|Z0101_1|||||||||||||||||||||||F
TXA|1|310|AP|||20250128144310||||||Z0101_1|||||AU|||||3213039^GRIFFON^Nicolas^^^^^^APHP^^^^^^20250128145310
OBX|1|RP|||nomDeFluxEai.026.20250128-145310.Z0101_1.01.pdf^libellé qui apparaît dans la colonne Description DPI, il faut concentrer dans les premiers caractères (avec des abréviations) l'essentiel sans quoi on aura un warning au QA du fait de la contrainte appelée tls-title-1||||||F
```