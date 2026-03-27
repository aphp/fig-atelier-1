[A MODIFIER : adapter au lien du projet]

[![pipeline status](https://gitlab.eds.aphp.fr/ID/ed/dm/ig/fig-base/badges/main/pipeline.svg)](https://gitlab.eds.aphp.fr/ID/ed/dm/ig/fig-base/-/commits/main)

Cet exemple d'Implementation Guide (IG) très simplifié sert de base pour le développement de nouveaux guides d'implémentation. La démarche d'élaboration d'un nouvel IG est expliquée dans le [wiki de ce repo](https://github.com/ansforge/IG-modele/wiki).
Le README ci-dessous constitue un template à adapter et compléter pour chaque projet.

# Contexte

## Contexte métier du projet

[A COMPLETER : doit contenir la description fonctionnelle du projet destinée à un profil non technique]

## Contexte technique du projet

[A COMPLETER : doit expliquer brièvement quelles ressources / profils sont utilisés, exemple implémentation où IG est utilisé]

## Construction de l'IG

"Construction de l'IG" signifie générer un site Web, des informations structurées et de la documentation d'accompagnement 
définies dans ce guide. Cela se fait via le [FHIR Implementation Guide Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation)
("IG Publisher"), un programme Java fourni par l'équipe FHIR pour la construction de guides d'implementation dans une
présentation standardisée.

### Prérequis avant la construction de l'IG

#### Prérequis technique

1. Vous avez besoin d'[installer java](https://adoptium.net/)
2. Vous avez besoin d'[installer jekyll](https://jekyllrb.com/docs/installation/)

### Configuration de l'environnement FHIR

Vérifier l'existence du fichier `$HOME/.fhir/fhir-settings.json`. Si ce fichier n'existe pas, créer le. Vérifier que le 
contenu du fichier est :

```json
{
	"servers": [
		{
			"url": "https://id.pages.data.aphp.fr/ed/dm/ig/fig-registry",
			"type": "fhir-package",
			"authenticationType": "none"
		},
		{
			"url": "https://dsn.pages.eds.aphp.fr/data-management/fhir-registry",
			"type": "fhir-package",
			"authenticationType": "none"
		}
	]
}
```

### Lancement de la construction

Si vous souhaitez le générer localement, ouvrez une fenêtre de commande et naviguer où le guide a été cloné.
Exécutez ensuite cette commande :

- Linux/macOS: `./gradlew buildIG`
- Windows: `.\gradlew.bat buildIG`

Ce script fera automatiquement deux choses pour vous :

1. Exécuter [SUSHI](https://fshschool.org/docs/sushi/). L'IG AP-HP - EDS est développé en [FHIR Shorthand (FSH)](http://build.fhir.org/ig/HL7/fhir-shorthand/),
   un langage spécifique de domaine (DSL) permettant de définir le contenu des FHIR IG. SUSHI transpile les fichiers FSH en
   fichiers JSON attendus par IG Publisher
2. Exécuter IG Publisher

Vous aurez besoin d'une connexion Internet active pour construire l'IG.

Lorsque la construction est terminée, vous pouvez ouvrir `output/index.html` dans votre navigateur pour voir le guide
construit localement.

### Exécution de SUSHI indépendamment de l'IG Publisher

Si vous souhaitez exécuter SUSHI sans créer l'intégralité de l'IG, vous pouvez exécuter la tâche gradle `sushiBuild`.

### Nettoyage + Lancement de la construction

Vous devez exécuter la tâche gradle `reBuildIG`.

## Répertoires et fichiers clés dans l'IG

- Les fichiers FHIR Shorthand (`.fsh`) définissant les ressources dans cet IG se trouvent dans `input/fsh/`.
  - Il existe une [extension de coloration syntaxique FSH](https://marketplace.visualstudio.com/items?itemName=MITRE-Health.vscode-language-fsh)
    pour [VSCode](https://code.visualstudio.com).
    Les fichiers FSH sont nommés en fonction de ce qu'ils contiennent.

- Les pages principales de l'IG construit sont générées à partir de [Markdown](https://daringfireball.net/projects/markdown/)
  trouvé dans `input/pagecontent/`. Ces pages doivent également être incluses dans `sushi-config.yaml` pour être compilées
  en HTML par l'IG Publisher.
- Il existe un certain nombre d'autres options de configuration importantes dans `sushi-config.yaml`, y compris le
  contenu du menu de l'IG construit.
- La source des diagrammes UML dans l'IG se trouve dans `input/images-source/` et DOIT avoir une extension `.plantuml`.
  Ceux-ci sont automatiquement convertis en SVG par l'éditeur IG et insérés en ligne dans les fichiers Markdown à l'aide
  de `{% include some-diagram.svg %}` (qui correspond à `input/images-source/some-diagram.plantuml`).

## Acronymes

* IG : Implementation Guide
* FHIR : Fast Healthcare Interoperability Resources
* FIG : FHIR Implementation Guide
* HL7 : Health Level Seven
* AP-HP : Assistance Publique - Hôpitaux de Paris

## Dépendances du guide d'implémentation

Vous trouverez la liste des dépendances dans `sushi-config.yaml` dans la section `dependencies` du fichier.
