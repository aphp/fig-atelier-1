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

🔖 **FML (StructureMap)**

```fml
group toMsh(source srcDocRef, target tgtMsh : Msh) {
  // --- Champs fixes MSH ---

  srcDocRef -> tgtMsh.msh1 = '|' "setFieldSep";

  srcDocRef -> tgtMsh.msh2 = ('^~\\&') "setEncoding";

  srcDocRef -> tgtMsh.msh5 = 'DPI' "setReceivingApp";

  srcDocRef -> tgtMsh.msh6 = 'APHP' "setReceivingFacility";

  // msh7 : date/heure au format HL7 v2 (YYYYMMDDHHmmss)
  // On utilise une expression unique sur now() pour éviter plusieurs appels retournant des timestamps différents.
  // now() retourne un format ISO 8601 (ex: 2024-01-15T14:30:00+01:00) ;
  // on supprime les séparateurs '-', 'T', ':' puis on tronque à 14 caractères.
  srcDocRef -> tgtMsh.msh7 = (now().toString().replace('-','').replace('T','').replace(':','').substring(0,14)) "setDateTime";

  srcDocRef -> tgtMsh.msh9 = 'MDM^T02' "setMessageType";

  srcDocRef -> tgtMsh.msh10 = uuid() "setMsgControlId";

  srcDocRef -> tgtMsh.msh11 = 'P' "setProcessingId";

  srcDocRef -> tgtMsh.msh12 = '2.5' "setVersion";

  srcDocRef -> tgtMsh.msh18 = '8859/15' "setCharSet";

  // --- Champs variables MSH ---

  // msh3 : application d'envoi (identifiant Hopex du custodian)
  srcDocRef.custodian as srcCustodian then {
    srcCustodian.identifier as srcCustIdentifier
      where system = 'https://interop.aphp.fr/info/Device/hopex' then {
        srcCustIdentifier.value as srcCustIdentVal -> tgtMsh.msh3 = srcCustIdentVal "setMsh3";
    } "navCustIdentifier";
  } "navCustodian";

  // msh4 : code hôpital (3 premiers caractères de l'identifiant Sirius)
  // Précondition : la valeur doit faire au moins 3 caractères (garde explicite).
  srcDocRef.author as srcServiceRespMed
    where (identifier.system = 'https://interop.aphp.fr/info/Organization/Sirius') then {
      srcServiceRespMed.identifier as srcServiceRespMedId then {
        srcServiceRespMedId.value as srcServiceRespMedIdValue
          where ($this.length() >= 3)
          -> tgtMsh.msh4 = (%srcServiceRespMedIdValue.substring(0,3)) "setMsh4";
      } "navUnitIdentifier";
  } "navUnit";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toEvn(source srcDocRef, target tgtEvn : Evn) {
  // evn2 : date de validation du document au format HL7 v2 (YYYYMMDDHHmmss)
  srcDocRef.content as srcContent then {
    srcContent.attachment as srcAttachment then {
      srcAttachment.creation as srcDate
        -> tgtEvn.evn2 = (%srcDate.toString().replace('-','').replace('T','').replace(':','').substring(0,14)) "setDate";
    } "navAttachment";
  } "navContent";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toPid(source srcDocRef, target tgtPid: Pid) {
  // Précondition : subject.reference doit pointer vers une ressource Patient contained (#id).
  // Si la référence est externe, aucun segment PID ne sera généré (échec silencieux documenté).
  srcDocRef.subject as srcSubject then {
    srcSubject.reference as srcSubjectReference then {
      srcDocRef.contained : Patient as srcDocSubj
        where ('#' + id = %srcSubjectReference) then {

        // pid3 : IPP patient
        srcDocSubj.identifier as srcDocSubjIdentifier
          where system = 'https://interop.aphp.fr/info/Patient/ipp'
          -> tgtPid.pid3 as tgtPid3,
             tgtPid3.cx5 = 'PN',
             tgtPid3.cx4 = 'APHP',
             tgtPid3.cx1 = (%srcDocSubjIdentifier.value) "setPid3";

        // pid5 : nom officiel
        srcDocSubj.name as srcSubjName where use = 'official' -> tgtPid.pid5 as tgtPid5 then {
          srcSubjName.family as srcSubjFamilyName -> tgtPid5.xpn1 = srcSubjFamilyName "setFamilyName";

          srcSubjName.given as srcSubjGivenName -> tgtPid5.xpn2 = srcSubjGivenName then {
            // xpn3 : prénoms secondaires extraits de l'extension fr-core birth-list-given-name.
            // Hypothèse : la valeur de l'extension contient le prénom usuel suivi d'un espace
            // puis des prénoms secondaires (ex: "Jean Pierre Marie").
            // On extrait la partie après le prénom usuel (longueur + 1 pour l'espace).
            // Si le format de l'extension change, cette logique doit être revisitée.
            srcSubjName.extension as srcSubjectGivenNamesExt
              where url = 'https://hl7.fr/ig/fhir/core/StructureDefinition/fr-core-patient-birth-list-given-name' then {
                srcSubjectGivenNamesExt.value : string as srcSubjectGivenNamesValue
                  -> tgtPid5.xpn3 = (%srcSubjectGivenNamesValue.toString().substring(%srcSubjGivenName.length() + 1)) "setGivenNames";
            } "navGivenNamesExt";
          } "setGivenName";
        } "navName";

        // pid7 : date de naissance au format HL7 v2 (YYYYMMDD)
        // On supprime les tirets du format ISO 8601 (YYYY-MM-DD -> YYYYMMDD).
        srcDocSubj.birthDate as srcSubjBirthDate
          -> tgtPid.pid7 = (%srcSubjBirthDate.toString().replace('-','')) "setBirthDate";

        // pid8 : sexe (via ConceptMap FHIR -> table HL7 0001)
        srcDocSubj.gender as srcSubjGender
          -> tgtPid.pid8 = translate(srcSubjGender, "https://interop.aphp.fr/ig/fhir/atelier/ConceptMap/patient-gender-to-aphp-table-0001", 'code') "setGender";

        // pid18 : NDA (valeur fixe provisoire — TODO: voir pv1-19)
        srcDocSubj -> tgtPid.pid18 = 'NDA' "setPid18";

      } "navContainedSubject";
    } "navSubjectReference";
  } "navSubject";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toPv1(source srcDocRef, target tgtPv1 : Pv1) {
  // pv12 : patient class, fixé à O (= consultation externe)
  srcDocRef -> tgtPv1.pv12 = 'O' "setPatientClass";

  // pv13 : lieu de visite (code UF Sirius)
  srcDocRef.author as srcServiceRespMed
    where (identifier.system = 'https://interop.aphp.fr/info/Organization/Sirius') then {
      srcServiceRespMed.identifier as srcServiceRespMedId -> tgtPv1.pv13 as tgtPv13 then {
        srcServiceRespMedId.value as srcServiceRespMedIdValue
          -> tgtPv13.pl1 = srcServiceRespMedIdValue,
             tgtPv13.pl11 = 'SIRIUS' "setUf"; // pl11 optionnel ; séparateurs requis jusqu'à pl4 minimum
      } "navIdentifier";
  } "navUnit";

  // pv119 : NDA
  // Le NDA n'est pas obligatoire, mais il doit y en avoir un.
  // La recherche d'un NDA en croisant l'IPP et l'unité garantit son existence ; lever une erreur si absent.
  // TODO: formaliser la représentation FHIR du NDA de consultation (List, Account, EpisodeOfCare...).
  srcDocRef -> tgtPv1.pv119 = 'NDA' "setPv1Nda";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toOrc(source srcDocRef, target tgtOrc : Orc) {
  // orc1 : order control, fixé à 'RE'
  srcDocRef -> tgtOrc.orc1 = 'RE' "setOrderControl";

  // orc2 : placer order number (identifiant Hopex du custodian + identifiant du document)
  srcDocRef.masterIdentifier as srcDocMI then {
    srcDocRef.custodian as srcCustodian then {
      srcCustodian.identifier as srcCustIdentifier
        where system = 'https://interop.aphp.fr/info/Device/hopex' then {
          srcCustIdentifier.value as srcCustIdentVal
            -> tgtOrc.orc2 = (%srcCustIdentVal + '_' + %srcDocMI.value) "setPlacerOrderNumber";
      } "navCustIdentifier";
    } "navCustodian";
  } "navMI";

  // orc13 : enterer's location (code hôpital sur 3 caractères + référentiel Sirius)
  // Précondition : utiliser le code hôpital du fichier structure, non le code UF.
  srcDocRef.author as srcServiceRespMed
    where (identifier.system = 'https://interop.aphp.fr/info/Organization/Sirius') then {
      srcServiceRespMed.identifier as srcServiceRespMedId -> tgtOrc.orc13 as tgtOrc13 then {
        srcServiceRespMedId.value as srcServiceRespMedIdValue
          -> tgtOrc13.pl4 = (%srcServiceRespMedIdValue.substring(0,3)),
             tgtOrc13.pl11 = 'SIRIUS' "setHosp";
      } "navIdentifier";
  } "navUnit";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toObr(source srcDocRef, target tgtObr : Obr) {
  // obr1 : set ID, fixé à 1
  srcDocRef -> tgtObr.obr1 = '1' "setId";

  // obr2 : placer order number (identifiant Hopex du custodian + identifiant du document)
  srcDocRef.masterIdentifier as srcDocMI then {
    srcDocRef.custodian as srcCustodian then {
      srcCustodian.identifier as srcCustIdentifier
        where system = 'https://interop.aphp.fr/info/Device/hopex' then {
          srcCustIdentifier.value as srcCustIdentVal
            -> tgtObr.obr2 = (%srcCustIdentVal + '_' + %srcDocMI.value) "setPlacerOrderNumber";
      } "navCustIdentifier";
    } "navCustodian";
  } "navMI";

  // obr25 : result status, fixé à F (Final) pour un message T02
  srcDocRef -> tgtObr.obr25 = 'F' "setResultStatus";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toTxa(source srcDocRef, target tgtTxa : Txa) {
  // txa1 : set ID, fixé à 1
  srcDocRef -> tgtTxa.txa1 = '1' "setId";

  // txa2 : type de document (via ConceptMap LOINC -> type Mediweb)
  srcDocRef.type as srcDocTypes then {
    srcDocTypes.coding as srcDocType
      where (system = 'http://loinc.org')
      -> tgtTxa.txa2 = translate(srcDocType, "https://interop.aphp.fr/ig/fhir/atelier/ConceptMap/xds-type-code-to-mediweb-document-type", 'code') "setDocType";
  } "navType";

  // txa3 : document content presentation, fixé à AP
  srcDocRef -> tgtTxa.txa3 = 'AP' "setDocContentPresentation";

  // txa6 : date de création au format HL7 v2 (YYYYMMDDHHmmss)
  srcDocRef.date as srcDate
    -> tgtTxa.txa6 = (%srcDate.toString().replace('-','').replace('T','').replace(':','').substring(0,14)) "setDate";

  // txa12 : unique document number (identifiant Hopex du custodian + identifiant du document)
  srcDocRef.masterIdentifier as srcDocMI then {
    srcDocRef.custodian as srcCustodian then {
      srcCustodian.identifier as srcCustIdentifier
        where system = 'https://interop.aphp.fr/info/Device/hopex' then {
          srcCustIdentifier.value as srcCustIdentVal
            -> tgtTxa.txa12 = (%srcCustIdentVal + '_' + %srcDocMI.value) "setUniqueDocNumber";
      } "navCustIdentifier";
    } "navCustodian";
  } "navMI";

  // txa17 : document completion status, fixé à AU (Authenticated)
  srcDocRef -> tgtTxa.txa17 = 'AU' "setDocCompletionStatus";

  // txa22 : authentication person (PPNtype)
  // Valeur par défaut si aucun authenticator contained n'est résolu.
  srcDocRef -> tgtTxa.txa22 as tgtTxa22 then {
    srcDocRef -> tgtTxa22.ppn1 = '0000000' "setDefaultAuthor";

    srcDocRef.authenticator as srcAuthenticator then {
      srcAuthenticator.reference as srcAuthenticatorRef then {
        srcDocRef.contained : PractitionerRole as srcPractRole
          where ('#' + id = %srcAuthenticatorRef) then {
            srcPractRole.practitioner as srcPractRef then {
              srcPractRef.reference as srcPractReference then {
                srcDocRef.contained : Practitioner as srcPract
                  where ('#' + id = %srcPractReference) then {

                  srcPract.name first as srcPractName then {
                    srcPractName.family as srcFamilyName -> tgtTxa22.ppn2 = srcFamilyName "setPractFamilyName";
                    srcPractName.given first as srcGivenName -> tgtTxa22.ppn3 = srcGivenName "setPractGivenName";
                  } "navPractName";

                  srcPract.identifier as srcPractIdentifier
                    where system = 'https://interop.aphp.fr/info/Practitioner/aph' then {
                      srcPractIdentifier.value as srcPractIdentifierValue
                        -> tgtTxa22.ppn1 = srcPractIdentifierValue,
                           tgtTxa22.ppn9 = 'APHP' "setPractIdentifier";
                  } "navPractIdentifier";

                } "navContainedPractitioner";
              } "navPractitionerRef";
            } "navPract";
        } "navContainedPractRole";
      } "navAuthenticatorRef";
    } "navAuthenticator";
  } "navTxa22Identity";

  // txa22.ppn15 : timestamp de l'authentification au format HL7 v2 (YYYYMMDDHHmmss)
  srcDocRef.content as srcContent then {
    srcContent.attachment as srcAttachment -> tgtTxa.txa22 as tgtTxa22 then {
      srcAttachment.creation as srcDate
        -> tgtTxa22.ppn15 = (%srcDate.toString().replace('-','').replace('T','').replace(':','').substring(0,14)) "setTimestamp";
    } "navTimestamp";
  } "navContent";
}
```

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

🔖 **FML (StructureMap)**

```fml
group toObx(source srcDocRef, target tgtObx : Obx) {
  // obx1 : set ID, fixé à 1
  srcDocRef -> tgtObx.obx1 = '1' "setId";

  // obx2 : value type, fixé à RP (Reference Pointer)
  srcDocRef -> tgtObx.obx2 = 'RP' "setValueType";

  // obx5 : observation value — lien vers le document physique
  // Nom de fichier construit : nomDeFluxEai.<UF3>.<YYYYMMDD>-<HHmmss>.<Hopex>_<masterID>.01.pdf
  // Précondition : l'identifiant Sirius doit comporter au moins 3 caractères.
  srcDocRef.masterIdentifier as srcMI then {
    srcDocRef.custodian as srcCustodian then {
      srcCustodian.identifier as srcCustIdentifier
        where system = 'https://interop.aphp.fr/info/Device/hopex' then {
          srcDocRef.content as srcContent then {
            srcContent.attachment as srcAttachment then {
              srcDocRef.author as srcRespMed
                where (identifier.system = 'https://interop.aphp.fr/info/Organization/Sirius') then {
                  srcRespMed.identifier as srcRespMedId -> tgtObx.obx5 as tgtObx5 then {
                    srcAttachment.title as srcDocTitle
                      -> tgtObx5.rp2 = srcDocTitle "setDocTitle";
                    srcRespMedId.value as srcUF then {
                      srcAttachment.creation as srcDate
                        -> tgtObx5.rp1 = ('nomDeFluxEai'
                            + '.' + %srcUF.substring(0,3)
                            + '.' + %srcDate.toString().replace('-','').replace('T','-').replace(':','').substring(0,15)
                            + '.' + %srcCustIdentifier.value + '_' + %srcMI.value
                            + '.01.pdf') "setDocName";
                    } "navUf";
                  } "navObx5";
              } "navAuthor";
            } "navAttachment";
          } "navContent";
      } "navCustIdentifier";
    } "navCustodian";
  } "navMI";

  // obx11 : observation result status, fixé à F (Final)
  srcDocRef -> tgtObx.obx11 = 'F' "setResultStatus";
}
```

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

🔖 **FML (StructureMap)**

```fml
group documentReferenceToT02(source srcDocRef : DocumentReference, target tgtMdm : Mdm) {
  srcDocRef -> tgtMdm.msh as tgtMsh then toMsh(srcDocRef, tgtMsh) "toMsh";
  srcDocRef -> tgtMdm.evn as tgtEvn then toEvn(srcDocRef, tgtEvn) "toEvn";
  srcDocRef -> tgtMdm.pid as tgtPid then toPid(srcDocRef, tgtPid) "toPid";
  srcDocRef -> tgtMdm.pv1 as tgtPv1 then toPv1(srcDocRef, tgtPv1) "toPv1";
  srcDocRef -> tgtMdm.orc as tgtOrc then toOrc(srcDocRef, tgtOrc) "toOrc";
  srcDocRef -> tgtMdm.obr as tgtObr then toObr(srcDocRef, tgtObr) "toObr";
  srcDocRef -> tgtMdm.txa as tgtTxa then toTxa(srcDocRef, tgtTxa) "toTxa";
  srcDocRef -> tgtMdm.obx as tgtObx then toObx(srcDocRef, tgtObx) "toObx";
}
```

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
