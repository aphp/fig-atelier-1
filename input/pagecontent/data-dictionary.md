Le tableau suivant récapitule les données du système d'information de l'AP-HP documentées dans le présent guide d'implémentation.

| [Domaine principal](#dp)  | [Données](#data)                                                                                                                | [Caractéristiques](#carac)                        |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| Infrastructure de soins   | <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> Établissement                                               | Données maîtres                                   |
| Infrastructure de soins   | <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> Unité fonctionnelle de l'AP-HP                                     | Données maîtres                                   |
| Infrastructure de soins   | <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> Autres niveaux de structures (Pole, Service, UM…)                   | Données maîtres                                   |
| Infrastructure de soins   | <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> Localisation géographique des structures                                 | Données maîtres                                   |
| Infrastructure de soins   | Professionnel de santé                                                             | Données maîtres                                   |
| Infrastructure de soins   | Professionnel de santé dans sa situation d'exercice au sein d'une structure  | Données maîtres                                   |
| Infrastructure de soins   | Agenda                                                                                | Données maîtres                                   |
| Infrastructure de soins   | Plage horaire/Créneau de rendez-vous                                                      | Données maîtres                                   |
| Parcours patient          | Patient                                                                                | Données maîtres ; Socle commun des EDSH           |
{: .grid}

Indications de lecture :

* <a name="dp" />Colonne "Domaine principal" : Il s'agit d'une caractérisation générale des données
* <a name="data" />Colonne "Données" : données du système d'information de l'AP-HP qui sont profilées.
* <a name="carac" />Colonne "Caractéristiques" :
  * Données transactionnelles: données qui représentent l'achèvement d'une action ou d'un plan d'action « métier ».  Il ne s’agit pas ici de « transaction » au sens informatique de « suite d’opérations modifiant l’état d’une base de données », mais de transaction au sens commercial ; dans notre contexte, un épisode de soin, par exemple, représente une transaction.
  * Données de référence : il s'agit des données utilisées pour organiser ou catégoriser d'autres données, ou pour relier des données à des informations à l'intérieur et à l'extérieur des limites de l'hôpital. Il s'agit généralement de codes et de descriptions ou de définitions.
  * Données maîtres : elles fournissent le contexte des données relatives à l'activité métier sous la forme de concepts communs et abstraits qui se rapportent à l'activité. Elles comprennent les détails (définitions et identifiants) des objets internes et externes impliqués dans les transactions métier, tels que les clients, les produits, les employés, les fournisseurs et les domaines contrôlés (valeurs de code).
  * Socle commun des EDSH : ces données ont été identifiées, au niveau national, comme devant être prioritairement collectées, mise en qualité, standardisées et mises à disposition au sein des entrepôts de données de santé hospitaliers.

<a name="tu" />La balise <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> indique que :

* Les ressources concernées ont été consciencieusement revues par les auteurs et sont considérées comme étant mûres pour être utilisées en production. Pour autant, elles ne sont exploitées dans aucun usage documenté de FHIR à l'AP-HP.
* **De prochaines versions de l'IG AP-HP Core pourraient introduire des changements significatifs dans les ressources <a style="padding-left: 3px; padding-right: 3px; border: 1px grey solid; font-weight: bold; color: black; background-color: #fff5e6" href="#tu" title="Standards Status = Trial Use">TU</a> incompatible avec les ressources précédement publiées.**
* Cette définition est inspirée de [celle proposée par FHIR](https://hl7.org/fhir/R4/versions.html#std-process), adaptée au contexte de l'AP-HP.

{% include markdown-link-references.md %}