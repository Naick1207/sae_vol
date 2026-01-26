CREATE TABLE VOL(
    numero INTEGER,
    compagnie VARCHAR(50),
    jourD DATE,
    heureD TIMESTAMP,
    terminalD VARCHAR(5),
    codeAeroportD INTEGER,
    jourA DATE,
    heureA TIMESTAMP,
    terminalA VARCHAR(5),
    codeAeroportA INTEGER,
    PRIMARY KEY(numero, compagnie, jourD, heureD),
    CHECK (codeAeroportA != codeAeroportD)
);

CREATE TABLE AEROPORT(
    code INTEGER PRIMARY KEY,
    nom VARCHAR(30),
    pays VARCHAR(30),
    ville VARCHAR(50)
);

ALTER TABLE VOL ADD FOREIGN KEY (codeAeroportD) REFERENCES AEROPORT(code);
ALTER TABLE VOL ADD FOREIGN KEY (codeAeroportA) REFERENCES AEROPORT(code);