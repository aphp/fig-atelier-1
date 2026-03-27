### À propos de cette aide

Cette page est destinée aux utilisateurs qui découvrent le Guide d'Implémentation FHIR AP-HP Core. Vous y trouverez une aide à la navigation, des réponses aux questions fréquentes et des conseils pour bien démarrer.

### Navigation dans le guide

#### Par où commencer ?

Si vous découvrez ce guide, nous vous recommandons de suivre ce parcours :

1. **[Page d'accueil](index.html)** : Comprendre pourquoi FHIR et pourquoi AP-HP Core
2. **[Glossaire](glossary.html)** : Se familiariser avec les termes essentiels (FHIR, profil, extension, etc.)

#### Structure du guide

Le guide est organisé en plusieurs sections principales :

| Section | Contenu | Pour qui ? |
|---------|---------|------------|
| [Accueil](index.html) | Présentation générale et objectifs | Tous |
| [Dictionnaire des données](data-dictionary.html) | Tableau contenant les profils FHIR | Tous |
| [Ressources de conformité](artifacts.html) | Liste technique des profils et extensions | Développeurs |
| [Glossaire](glossary.html) | Définitions des termes clés | Tous |
{: .grid}

### Questions fréquentes (FAQ)

#### Qu'est-ce que FHIR ?

**FHIR** (Fast Healthcare Interoperability Resources) est un standard international développé par HL7 pour l'échange de données de santé. Il utilise des technologies web modernes (REST, JSON, XML) pour faciliter l'interopérabilité entre systèmes de santé.

**En pratique :** FHIR définit des "ressources" standardisées comme `Patient`, `Observation`, `Encounter` qui représentent des concepts médicaux. Ces ressources peuvent être adaptées via des "profils" pour répondre aux besoins locaux.

#### Qu'est-ce qu'un guide d'implémentation (Implementation Guide) ?

Un **guide d'implémentation** (ou IG) est une spécification technique qui documente comment utiliser FHIR dans un contexte particulier. Il contient :

- Des **profils** : adaptations des ressources FHIR de base
- Des **extensions** : ajouts d'éléments de données spécifiques
- Des **jeux de valeurs** : listes de codes autorisés
- Des **exemples** : instances concrètes pour illustrer l'usage
- De la **documentation** : explications métier et techniques

**Le guide AP-HP Core** est le guide de référence de l'AP-HP. Il définit les règles communes que tous les projets FHIR à l'AP-HP doivent respecter.

#### Quelle est la différence entre un profil et une extension ?

**Un profil** adapte une ressource FHIR existante en :
- Rendant certains éléments obligatoires
- Restreignant les valeurs possibles
- Ajoutant des contraintes spécifiques

**Exemple :** Le profil `CorePatient` adapte la ressource `Patient` de FHIR pour ajouter les contraintes spécifiques à l'AP-HP (identifiants institutionnels, etc.).

**Une extension** ajoute de nouveaux éléments de données qui n'existent pas dans FHIR de base.

**Exemple :** Une extension pour documenter le "statut INS" d'un patient, concept spécifique au contexte français.

#### Qu'est-ce que le principe de robustesse ?

Le **principe de robustesse** est une règle fondamentale de l'AP-HP Core : les profils doivent rester génériques et ouverts plutôt que restrictifs.

**Concrètement :**
- On n'ajoute pas de contraintes inutiles
- On élargit les références possibles plutôt que de les restreindre
- On évite de changer les cardinalités
- On ne marque pas d'éléments comme "Must Support" dans AP-HP Core

**Pourquoi ?** Pour que les profils AP-HP Core soient réutilisables dans tous les contextes et projets de l'AP-HP.

#### Quel est le lien entre AP-HP Core et les profils nationaux (ANS/Interop'Santé) ?

L'AP-HP Core **spécialise systématiquement les profils nationaux** quand ils existent. Cela garantit :
- La compatibilité avec l'écosystème national
- L'interopérabilité avec les autres établissements
- L'alignement avec le CI-SIS (Cadre d'Interopérabilité)

**Exemple :** `CorePatient` spécialise `FRCorePatientProfile` qui est le profil national français.

#### Comment sont organisés les domaines métiers ?

Les domaines métiers regroupent les concepts liés à un même périmètre fonctionnel. Chaque domaine comprend :

1. **Un modèle conceptuel** : schéma des concepts et de leurs relations
2. **Un glossaire** : définitions précises des termes
3. **Des profils FHIR** : implémentation technique des concepts
4. **Des exemples** : cas d'usage concrets

#### Qu'est-ce qu'une ressource de conformité ?

Une **ressource de conformité** définit des règles que les données doivent respecter. Les principales sont :

- **StructureDefinition** : définit des profils ou extensions
- **ValueSet** : définit des jeux de valeurs (listes de codes autorisés)
- **CodeSystem** : définit des systèmes de codage
- **SearchParameter** : définit des critères de recherche
- **CapabilityStatement** : décrit les capacités d'un serveur FHIR

Vous pouvez les consulter dans la section [Ressources de conformité](artifacts.html).

#### Comment lire un profil FHIR ?

Quand vous consultez un profil, regardez ces sections :

1. **Introduction** : contexte métier et objectif du profil
2. **Formal Views** (onglets) :
  - **Key Elements** : vue sur les élements principaux du profil
  - **Differential** : uniquement les changements par rapport au parent
  - **Snapshot** : vue complète avec tous les éléments hérités
   
3. **Exemples** : instances concrètes du profil
4. **Mappings** : correspondances avec d'autres standards

**Astuce :** Commencez par lire l'introduction et les exemples avant de regarder les détails techniques.

#### Que signifie "Must Support" ?

**Must Support** est un marqueur qui indique qu'un élément doit être pris en charge par les systèmes :

- **Pour les producteurs :** Vous devez fournir cet élément s'il est disponible dans vos données
- **Pour les consommateurs :** Vous devez être capable de traiter cet élément sans erreur (mais vous pouvez choisir de ne pas l'utiliser)

**Note :** Dans AP-HP Core, "Must Support" n'est **pas utilisé** pour préserver la robustesse. Il est utilisé uniquement dans les guides d'implémentation de projets spécifiques.

### Ressources utiles

#### Documentation de référence

- [Spécification FHIR R4](http://hl7.org/fhir/R4/) : documentation officielle HL7 FHIR (en anglais)
- [Documentation ANS](https://interop.esante.gouv.fr/ig/documentation/) : bonnes pratiques et guides nationaux français
- [Guides Interop'Santé](https://interop.esante.gouv.fr/) : profils nationaux français

#### Outils

- [FHIR Shorthand (FSH)](https://fshschool.org/) : langage pour définir des ressources FHIR de façon simple
- [AP-HP FormBuilder](https://aphp.github.io/formbuilder/) : outil pour créer des questionnaires FHIR
- [FHIR MapBuiler](https://github.com/aphp/fhir-mapbuilder) : Extension VS Code permettant le support du développement de ressource `StructureMap` par l'usage du FHIR Mapping Language (FML)

#### Terminologies

Les principales terminologies utilisées dans le contexte français :
- **SNOMED CT** : terminologie clinique internationale
- **LOINC** : codes pour les observations et examens de laboratoire
- **CCAM** : Classification Commune des Actes Médicaux (France)
- **CIM-10** : Classification Internationale des Maladies
- **ATC** : Classification des médicaments

### Besoin d'aide supplémentaire ?

Si vous avez des questions qui ne sont pas couvertes dans cette aide :

1. Consultez le [glossaire](glossary.html) pour les définitions des termes
2. Explorez les [exemples](artifacts.html#example-example-instances) pour voir des cas concrets

{% include markdown-link-references.md %}
