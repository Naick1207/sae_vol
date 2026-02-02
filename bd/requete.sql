select a1.VILLE from AEROPORT a1 join VOL on VOL.codeAeroportA=a1.code join AEROPORT a2 on VOL.codeAeroportD=a2.code where a2.ville='Paris';

select aeroFin.ville from AEROPORT aeroFin
join VOL vol2 on aeroFin.code = vol2.codeAeroportA
join AEROPORT aeroMid on aeroMid.code = vol2.codeAeroportD
join VOL vol1 on aeroMid.code = vol1.codeAeroportA
join AEROPORT aeroDep on aeroDep.code = vol1.codeAeroportD
where aeroDep.ville = 'Paris' and vol2.tempsD >= vol1.tempsA;

select aeroFin.ville from AEROPORT aeroFin
join VOL vol3 on aeroFin.code = vol3.codeAeroportA
join AEROPORT aeroMid2 on aeroMid2.code = vol3.codeAeroportD
join VOL vol2 on aeroMid2.code = vol2.codeAeroportA
join AEROPORT aeroMid1 on aeroMid1.code = vol2.codeAeroportD
join VOL vol1 on aeroMid1.code = vol1.codeAeroportA
join AEROPORT aeroDep on aeroDep.code = vol1.codeAeroportD
where aeroDep.ville = 'Paris' and vol2.tempsD >= vol1.tempsA and vol3.tempsD >= vol2.tempsA;