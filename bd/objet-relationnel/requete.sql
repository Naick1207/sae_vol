-- Question 2

-- a - Pour chaque vol, donner le nombre de personnes de l’équipage, par fonction.
SELECT numero, e.fonction, COUNT(e.nom) nb_equipage FROM VOL, TABLE(VOL.equipage) e
GROUP BY numero, e.fonction
ORDER BY numero, e.fonction;

-- b - Pour chaque pilote, indiquer combien des vols lui sont associés.
SELECT e.nom, COUNT(numero) nb_vol FROM VOL, TABLE(VOL.equipage) e
WHERE e.fonction = 'Pilote'
GROUP BY e.nom
ORDER BY e.nom;

-- c - L’impact d’un indice de qualité est donné par le produit de sa valeur et du poids que lui est attribué. Pour chaque vol, indiquer l’impact de chaque indice de qualité.
SELECT numero, i.nom, i.impact() as impact FROM VOL, TABLE(VOL.IndicesQualites) i
ORDER BY numero, i.nom;

-- d - Pour chaque indice de qualité, calculer son impact moyen
SELECT i.nom, SUM(i.impact()) / COUNT(numero) as moyenne_impact FROM VOL, TABLE(VOL.IndicesQualites) i
GROUP BY i.nom;