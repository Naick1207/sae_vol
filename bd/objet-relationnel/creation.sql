CREATE OR REPLACE TYPE equipage as OBJECT (
    nom varchar(20), fonction varchar(20),
    member FUNCTION get_name RETURN varchar(20)
);
/
CREATE OR REPLACE TYPE BODY equipage as
    member FUNCTION get_name RETURN varchar(20) IS
    BEGIN
    return self.nom;
    END;
END;
/
CREATE TYPE equipageTab as table of equipage;
/











CREATE TABLE VOL(
    numero INTEGER,
    compagnie VARCHAR(50),
    tempsD TIMESTAMP,
    terminalD VARCHAR(5),
    codeAeroportD INTEGER,
    tempsA TIMESTAMP,
    terminalA VARCHAR(5),
    codeAeroportA INTEGER,
    equipage equipageTab,
    PRIMARY KEY(numero, compagnie, tempsD),
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