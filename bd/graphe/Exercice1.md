Pour modéliser ma base de données dans le modèle graphe, je me baserai sur le modèle relationnel (Partie 3.1).

Le modèle relationnel contient 2 tables:
- La table AEROPORT contenant le code d'aéroport, son nom, sa ville, et son pays
- La table VOL contenant le numéro de vol, la compagnie de départ, les temps de départ et d'arrivée, sur quels terminaux le vol part/arrive et enfin il est relié à 2 AEROPORT, un de départ et un d'arrivé

Ainsi on peut concevoir notre modèle graphe de cette manière:
- Les noeuds sont représentés par les AEROPORTS, avec les mêmes attributs
- Ces noeuds sont reliés par des VOL-VERS, qui font donc ici office de RELATION, allant de l'aéroport de départ à l'aéroport d'arrivée. Ces relations auront les mêmes attributs que la table VOL à l'exception des terminaux et des horaires (qui ne sont pas demandés)

Les données utilisées pour l'initialisation sont les mêmes que celles trouvables dans la partie "relationnel", avec l'ajout d'un vol allant de New York à Paris pour vérifier que dès que l'on est pas dans une boucle.