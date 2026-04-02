-- Question 2

-- a - Donner les villes que nous pouvons atteindre par vols directs qui partent de Paris.
select a1.VILLE from AEROPORT a1
join VOL on VOL.codeAeroportA=a1.code
join AEROPORT a2 on VOL.codeAeroportD=a2.code
where a2.ville='Paris';

/*
b - En considérant les horaires des vols, veuillez fournir la liste des villes accessibles
depuis Paris avec un vol comprenant UNE correspondance. L’objectif est de
permettre aux passagers de réaliser leur correspondance.
*/
select aeroFin.ville from AEROPORT aeroFin
join VOL vol2 on aeroFin.code = vol2.codeAeroportA
join AEROPORT aeroMid on aeroMid.code = vol2.codeAeroportD
join VOL vol1 on aeroMid.code = vol1.codeAeroportA
join AEROPORT aeroDep on aeroDep.code = vol1.codeAeroportD
where aeroDep.ville = 'Paris' and vol2.tempsD >= vol1.tempsA;

/*
c - En considérant les horaires des vols, veuillez fournir la liste des villes accessibles
depuis Paris avec un vol comprenant DEUX correspondances.
*/
select aeroFin.ville from AEROPORT aeroFin
join VOL vol3 on aeroFin.code = vol3.codeAeroportA
join AEROPORT aeroMid2 on aeroMid2.code = vol3.codeAeroportD
join VOL vol2 on aeroMid2.code = vol2.codeAeroportA
join AEROPORT aeroMid1 on aeroMid1.code = vol2.codeAeroportD
join VOL vol1 on aeroMid1.code = vol1.codeAeroportA
join AEROPORT aeroDep on aeroDep.code = vol1.codeAeroportD
where aeroDep.ville = 'Paris' and vol2.tempsD >= vol1.tempsA and vol3.tempsD >= vol2.tempsA;

-- d - Veuillez fournir la liste des villes accessibles depuis Paris, en tenant compte des horaires de vol, avec des vols directs ou un nombre quelconque de correspondances.
WITH aeroDebut(code, ville, tempsArrivee) AS (
    SELECT aero2.code, aero2.ville, VOL.tempsA FROM AEROPORT aero2
    JOIN VOL ON aero2.code = VOL.codeAeroportA
    JOIN AEROPORT aeroParis ON aeroParis.code = VOL.codeAeroportD
    WHERE aeroParis.ville = 'Paris'
    UNION ALL
    SELECT aeroFin.code, aeroFin.ville, VOL.tempsA FROM aeroDebut
    JOIN VOL ON aeroDebut.code = VOL.codeAeroportD
    JOIN AEROPORT aeroFin ON aeroFin.code = VOL.codeAeroportA
    WHERE VOL.tempsD >= aeroDebut.tempsArrivee

)
CYCLE code SET cycle TO 1 DEFAULT 0
SELECT DISTINCT ville FROM aeroDebut;