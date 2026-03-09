from .extensions import db
from sqlalchemy import String

class Aeroport(db.Model):
    __tablename__ = "aeroport"
    code = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(30))
    pays = db.Column(db.String(30))
    ville = db.Column(db.String(50))

class Vol(db.Model):
    __tablename__ = "vol"
    numero = db.Column(db.Integer, primary_key=True)
    compagnie = db.Column(db.String(50), primary_key=True)
    tempsD = db.Column(String(50), primary_key=True)
    terminalD = db.Column(db.String(5))
    codeAeroportD = db.Column(db.Integer, db.ForeignKey("aeroport.code"))
    tempsA = db.Column(String(50))
    terminalA = db.Column(db.String(5))
    codeAeroportA = db.Column(db.Integer, db.ForeignKey("aeroport.code"))

def get_all_vols():
    return Vol.query.all()

def get_vol(numero, compagnie, tempsD):
    return Vol.query.filter_by(
        numero=numero,
        compagnie=compagnie,
        tempsD=tempsD
    ).first()

def create_vol(numero, compagnie, tempsD, terminalD, codeAeroportD, tempsA, terminalA, codeAeroportA):
    vol = Vol(
        numero=numero,
        compagnie=compagnie,
        tempsD=tempsD,
        terminalD=terminalD,
        codeAeroportD=codeAeroportD,
        tempsA=tempsA,
        terminalA=terminalA,
        codeAeroportA=codeAeroportA
    )
    db.session.add(vol)
    db.session.commit()
    return vol

def update_vol(numero, compagnie, tempsD, **kwargs):
    vol = get_vol(numero, compagnie, tempsD)
    if vol is None:
        return None
    for key, value in kwargs.items():
        if hasattr(vol, key):
            setattr(vol, key, value)
    db.session.commit()
    return vol

def get_all_aeroports():
    return Aeroport.query.all()

def get_aeroport(code):
    return Aeroport.query.filter_by(code=code).first()

def create_aeroport(nom, pays, ville):
    aeroport = Aeroport(nom=nom, pays=pays, ville=ville)
    db.session.add(aeroport)
    db.session.commit()
    return aeroport

def update_aeroport(code, **kwargs):
    aeroport = get_aeroport(code)
    if aeroport is None:
        return None
    for key, value in kwargs.items():
        if hasattr(aeroport, key):
            setattr(aeroport, key, value)
    db.session.commit()
    return aeroport
