INSERT INTO AEROPORT VALUES(456, 'Antonio Carlos', 'Brésil', 'Rio de Janeiro');
INSERT INTO AEROPORT VALUES(123, 'Charles de Gaulle', 'France', 'Paris');
INSERT INTO AEROPORT VALUES(100, 'Charles de Gaulle', 'France', 'Paris');
INSERT INTO AEROPORT VALUES(200, 'Schiphol', 'Pays-Bas', 'Amsterdam');
INSERT INTO AEROPORT VALUES(300, 'Barajas', 'Espagne', 'Madrid');
INSERT INTO AEROPORT VALUES(400, 'Fiumicino', 'Italie', 'Rome');
INSERT INTO AEROPORT VALUES(500, 'Heathrow', 'Royaume-Uni', 'Londres');
INSERT INTO AEROPORT VALUES(600, 'Tegel', 'Allemagne', 'Berlin');
INSERT INTO AEROPORT VALUES(700, 'John F Kennedy', 'USA', 'New York');

INSERT INTO VOL VALUES(
    442, 'AirFrance', to_timestamp('12/02/2026 12:34:56', 'DD/MM/YYYY HH24:MI:SS'), 
    '1', 123, to_timestamp('14/02/2026 14:42:23', 'DD/MM/YYYY HH24:MI:SS'), '2E', 456, 
    equipageTab(equipage('Goscinny', 'Pilote'), equipage('Uderzo', 'Commissaire')), 
    IndiceQualiteListe(IndiceQualite('carbone', 3, 4), IndiceQualite('securite', 4, 5), IndiceQualite('prix', 4, 3))
);

INSERT INTO VOL VALUES(
    1, 'AirFrance', TO_TIMESTAMP('10/03/2026 08:00:00','DD/MM/YYYY HH24:MI:SS'),
    '2A', 100, TO_TIMESTAMP('10/03/2026 09:30:00','DD/MM/YYYY HH24:MI:SS'), 'B', 200,
    equipageTab(equipage('Lefebvre', 'Pilote'), equipage('Bernard', 'Steward')),
    IndiceQualiteListe(IndiceQualite('carbone', 4, 2), IndiceQualite('securite', 5, 5), IndiceQualite('prix', 3, 3))
);

INSERT INTO VOL VALUES(
    2, 'AirFrance', TO_TIMESTAMP('10/03/2026 07:45:00','DD/MM/YYYY HH24:MI:SS'),
    '2B', 100, TO_TIMESTAMP('10/03/2026 10:00:00','DD/MM/YYYY HH24:MI:SS'), 'T1', 300,
    equipageTab(equipage('Moreau', 'Pilote'), equipage('Petit', 'Co-Pilote')),
    IndiceQualiteListe(IndiceQualite('carbone', 3, 4), IndiceQualite('securite', 4, 5), IndiceQualite('prix', 2, 3))
);

INSERT INTO VOL VALUES(
    3, 'Alitalia', TO_TIMESTAMP('10/03/2026 09:00:00','DD/MM/YYYY HH24:MI:SS'),
    '1C', 100, TO_TIMESTAMP('10/03/2026 11:00:00','DD/MM/YYYY HH24:MI:SS'), 'T3', 400,
    equipageTab(equipage('Bianchi', 'Pilote'), equipage('Rossi', 'Hôtesse')),
    IndiceQualiteListe(IndiceQualite('carbone', 5, 1), IndiceQualite('securite', 4, 5), IndiceQualite('prix', 5, 4))
);

INSERT INTO VOL VALUES(
    4, 'KLM', TO_TIMESTAMP('10/03/2026 11:00:00','DD/MM/YYYY HH24:MI:SS'),
    'C', 200, TO_TIMESTAMP('10/03/2026 12:00:00','DD/MM/YYYY HH24:MI:SS'), '5', 500,
    equipageTab(equipage('Van Damme', 'Pilote')),
    IndiceQualiteListe(IndiceQualite('carbone', 2, 4), IndiceQualite('securite', 5, 5), IndiceQualite('prix', 4, 3))
);

INSERT INTO VOL VALUES(
    5, 'Iberia', TO_TIMESTAMP('10/03/2026 12:00:00','DD/MM/YYYY HH24:MI:SS'),
    'T2', 300, TO_TIMESTAMP('10/03/2026 14:30:00','DD/MM/YYYY HH24:MI:SS'), 'A', 600,
    equipageTab(equipage('Gomez', 'Pilote'), equipage('Lopez', 'Co-Pilote')),
    IndiceQualiteListe(IndiceQualite('carbone', 3, 3), IndiceQualite('securite', 3, 5), IndiceQualite('prix', 4, 4))
);

INSERT INTO VOL VALUES(
    6, 'BritishAirways', TO_TIMESTAMP('10/03/2026 15:00:00','DD/MM/YYYY HH24:MI:SS'),
    '5', 500, TO_TIMESTAMP('10/03/2026 22:00:00','DD/MM/YYYY HH24:MI:SS'), '4', 700,
    equipageTab(equipage('Walker', 'Pilote'), equipage('Smith', 'Steward')),
    IndiceQualiteListe(IndiceQualite('carbone', 1, 5), IndiceQualite('securite', 5, 5), IndiceQualite('prix', 2, 2))
);