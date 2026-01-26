CREATE TABLE VOL(
    numero INTEGER,
    compagnie TEXT,
    jourD DATE,
    heureD TIME,
    terminalD VARCHAR(5),
    codeAeroportD INTEGER,
    jourA DATE,
    heureA TIME,
    terminalA VARCHAR(5),
    codeAeroportA INTEGER,
    PRIMARY KEY(numero, compagnie, jourD, heureD),
    CHECK (codeAeroportA != codeAeroportD)
);

CREATE TABLE AEROPORT(
    code INT,
    nom TEXT,
    pays TEXT,
    ville TEXT
);

ALTER TABLE VOL FOREIGN KEY (codeAeroportD) REFERENCES AEROPORT(code);
ALTER TABLE VOL FOREIGN KEY (codeAeroportA) REFERENCES AEROPORT(code);