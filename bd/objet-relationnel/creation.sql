CREATE OR REPLACE TYPE equipage as OBJECT (
    nom varchar2(20), fonction varchar2(20),
    member FUNCTION get_name RETURN varchar2
);
/
CREATE OR REPLACE TYPE BODY equipage as
    member FUNCTION get_name RETURN varchar2 IS
    BEGIN
    return self.nom;
    END get_name;
END;
/
CREATE TYPE equipageTab as table of equipage;
/

CREATE OR REPLACE TYPE IndiceQualite AS OBJECT (
    nom VARCHAR2(20), valeur INTEGER, poids INTEGER,
    member FUNCTION get_poids RETURN INTEGER
);
/
CREATE OR REPLACE TYPE BODY IndiceQualite AS
    member FUNCTION get_poids RETURN INTEGER IS
    BEGIN
    return self.poids;
    END get_poids;
END;
/
CREATE TYPE IndiceQualiteListe AS VARRAY(3) OF IndiceQualite;
/










CREATE TABLE VOL(
    numero INTEGER,
    compagnie VARCHAR2(50),
    tempsD TIMESTAMP,
    terminalD VARCHAR2(5),
    codeAeroportD INTEGER,
    tempsA TIMESTAMP,
    terminalA VARCHAR2(5),
    codeAeroportA INTEGER,
    equipage equipageTab,
    IndicesQualites IndiceQualiteListe,
    PRIMARY KEY(numero, compagnie, tempsD),
    CHECK (codeAeroportA != codeAeroportD)
) NESTED TABLE equipage STORE AS equipage_nt;
/

CREATE TABLE AEROPORT(
    code INTEGER PRIMARY KEY,
    nom VARCHAR2(30),
    pays VARCHAR2(30),
    ville VARCHAR2(50)
);
/

ALTER TABLE VOL ADD FOREIGN KEY (codeAeroportD) REFERENCES AEROPORT(code);
ALTER TABLE VOL ADD FOREIGN KEY (codeAeroportA) REFERENCES AEROPORT(code);