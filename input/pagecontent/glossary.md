<a name="ci-sis" />**Cadre d'Interopérabilité des Systèmes d'Information de Santé (CI-SIS)** : Référentiel publié par l'Agence du Numérique en Santé (ANS) définissant les normes, standards et bonnes pratiques à respecter pour assurer l'interopérabilité technique, syntaxique et sémantique (couches métier, service et transport) afin de structurer et sécuriser les échanges de données entre systèmes d'information de santé en France.

<a name="design-first" />**Design First** : approche de développement logiciel dans laquelle la conception des modèles (données, processus, interfaces) est réalisée en amont du développement. Elle s'oppose à l'approche code first, où les modèles sont dérivés du code existant. Le design first favorise la clarté, la standardisation, la communication entre métiers et techniques, et s'inscrit dans une logique d'interopérabilité by design.

<a name="dpi" />**DPI** : Dossier Patient Informatisé.

<a name="fhir" />**Fast Healthcare Interoperability Resources (FHIR)** : Standard d'interopérabilité développé par HL7, conçu pour faciliter l'échange de données cliniques à l'ère du web. FHIR propose :


>* des ressources normalisées (`Patient`, `Observation`, `Encounter`, etc.),
>* des profils pour spécialiser les ressources à un contexte donné,
>* des mécanismes d'alignement structurel et sémantique (`StructureMap` et `ConceptMap`),
>* un usage natif des technologies web (REST, JSON, XML),


permettant une interopérabilité structurée, extensible et moderne, adaptée aussi bien aux besoins des systèmes hospitaliers qu'à ceux des applications mobiles ou des projets de recherche.

<a name="fml" />**FHIR Mapping Language** : le FHIR Mapping Language (FML) est un langage de transformation développée par HL7. Il permet de décrire les règles de transformation de données entre différents modèles d'information de santé, notamment entre des structures FHIR et des formats non-FHIR (comme HL7 v2, CDA, ou des systèmes propriétaires).

<a name="fsh" />**FHIR Shorthand** : FHIR Shorthand (FSH) est un langage spécifique de domaine développée par HL7. Il permet de définir des ressources FHIR de manière simple et compacte. Il permet aux auteurs d'exprimer leur intention sans avoir besoin de connaitres toutes les subtilités de FHIR.

<a name="hds" />**Hub de Données de Santé** : un Hub de Données de Santé est un dépôt central de données standardisées provenant de sources multiples au sein d'un SIH.

<a name="io" />**Interopérabilité** : Capacité de différents systèmes d'information à échanger, comprendre et exploiter des données de manière cohérente. Elle peut être :


>* technique (échange de données au niveau des formats et protocoles),
>* syntaxique/sémantique (structure des données/signification des données),
>* organisationnelle (alignement des usages et processus),
>* juridique (conformité à la réglementation)


En santé, l'interopérabilité est essentielle pour assurer la continuité des soins et la réutilisation des données à des fins de soins, de pilotage ou de recherche.

<a name="cdm" />**Modèle de donnée conceptuel** : l'objectif d'un modèle de donnée conceptuel (MDC) est de saisir la vision d'ensemble sur un périmètre précis : quels sont les concepts fondamentaux d'un domaine, d'un périmètre fonctionnel ou d'un processus métier et comment sont-ils liés entre eux ? Le modélisateur doit d'écouter "le métier" — les experts du domaine et les personnes sur le terrain qui comprennent comment les choses fonctionnent. Le modélisateur va apprendre leur "langage métier" et identifier les concepts clés nécessaires pour modéliser un domaine, un périmètre fonctionnel ou un processus métier. La priorité est la clarté, la structure et la compréhension partagée, au niveau le plus abstrait. En termes génériques, il s'agit d'identifier des entités et la manière dont elles sont liées entre elles. Le MDC est un outil de communication. Une analogie possible est celle d'un "plan de ville".

<a name="mdl" />**Modèle de donnée logique** : Représentation formelle des données qui décrit de manière détaillée les entités, leurs attributs, leurs relations et leurs contraintes, indépendamment de toute technologie ou solution de mise en œuvre. Il précise la structure de l'information telle qu'elle doit être comprise et manipulée, sans se limiter à un format ou à un système particulier.

<a name="mde" />**Ingénierie Dirigée par les Modèles (IDM) / Model-Driven Engineering (MDE)** : méthodologie d'ingénierie logicielle qui repose sur l'utilisation systématique de modèles formels à différents niveaux d'abstraction pour concevoir, transformer et générer automatiquement des éléments du système (code source, documentation, configuration, etc.). Le MDE est particulièrement utile pour garantir la traçabilité, la réutilisabilité et la conformité aux standards, notamment dans les systèmes complexes comme ceux de la santé.

<a name="sn" />**Service numérique (SN)** : Prestation fournie en ligne, reposant sur des infrastructures électroniques, permettant l'accès, le stockage, la diffusion ou l'échange d'informations et de contenus. Selon le Règlement sur les services numériques (Digital Services Act), cette notion englobe aussi bien les services intermédiaires (par exemple : fourniture d’accès à internet, hébergement de données, plateformes en ligne) que les services spécifiques qui facilitent la mise en relation, la communication ou la consommation de contenus et produits numériques.

<a name="si" />**Système d'Information (SI)** : Ensemble organisé de ressources humaines, matérielles, logicielles, de données et de procédures qui permet de collecter, stocker, traiter et diffuser l'information au sein d'une organisation, en vue de soutenir ses activités, sa prise de décision et sa stratégie.

<a name="sih" />**Système d'Information Hospitalier (SIH)** : Ensemble organisé des ressources (logiciels, bases de données, équipements, procédures, etc.) qui permet de gérer l'ensemble des flux d'informations au sein d'un établissement de santé. Il vise à soutenir l'activité médicale, soignante, administrative et logistique de l'hôpital en assurant la circulation, le stockage, la sécurité et la traçabilité des données.

**Profil** : Spécialisation d'une ressource ou d'un type de données FHIR, matérialisée par une StructureDefinition de type "constraint", qui définit un ensemble de règles et de contraintes adaptées à un contexte d'usage particulier. Un profil permet de :

* Restreindre la cardinalité des éléments (rendre obligatoire, exclure, limiter)
* Fixer des valeurs constantes
* Ajouter des extensions spécifiques au contexte
* Définir des slices sur les éléments répétables
* Spécialiser les types de données autorisés
* Lier des jeux de valeurs (ValueSets) aux éléments codés

Exemple AP-HP : Le profil FRCorePatientProfile (Interop'santé) est spécialisé en CorePatient pour ajouter des contraintes spécifiques à l'AP-HP (identifiants institutionnels obligatoires, extensions métier, etc.).

**Extension** : Mécanisme standardisé FHIR permettant d'ajouter des éléments de données supplémentaires à toute ressource ou type de données, au-delà de leur définition de base. Chaque extension est identifiée par une URI pointant vers sa définition formelle (StructureDefinition) et peut contenir soit une valeur simple, soit une structure complexe d'extensions imbriquées.

**Slice (découpage)** : Mécanisme de profilage FHIR permettant de diviser un élément répétable (cardinalité 0..* ou 1..*) en plusieurs sous-ensembles distincts, chacun avec ses propres contraintes et sa signification métier spécifique. Chaque slice est identifié par un discriminateur (un ou plusieurs éléments dont la valeur permet de déterminer à quelle slice appartient une occurrence donnée).
Exemple AP-HP : L'élément Patient.identifier peut être découpé en slices pour distinguer l'INS, le numéro de dossier, l'IPP, etc., chaque slice ayant ses propres règles de cardinalité et de validation.

**Jeu de valeurs (ValueSet)** : Ensemble de codes issus d'une ou plusieurs terminologies, définissant les valeurs autorisées pour un élément donné.

**Profil "hook"** : Profil minimal servant de point d'ancrage pour une donnée ne disposant pas encore de profil de référence.

{% include markdown-link-references.md %}