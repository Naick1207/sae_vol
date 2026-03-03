from .extensions import db
from datetime import datetime

class Aeroport(db.Model):
    __tablename__ = "aeroport"
    
    code = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(30))
    pays = db.Column(db.String(30))
    ville = db.Column(db.String(50))
    
    vols_depart = db.relationship("Vol", back_populates="aeroport_depart", foreign_keys="Vol.codeAeroportD")
    vols_arrivee = db.relationship("Vol", back_populates="aeroport_arrivee", foreign_keys="Vol.codeAeroportA")

class Vol(db.Model):
    __tablename__ = "vol"
    
    numero = db.Column(db.Integer, primary_key=True, autoincrement=True)  
    compagnie = db.Column(db.String(50))
    tempsD = db.Column(db.DateTime)
    terminalD = db.Column(db.String(5))
    codeAeroportD = db.Column(db.Integer, db.ForeignKey("aeroport.code"))
    tempsA = db.Column(db.DateTime)
    terminalA = db.Column(db.String(5))
    codeAeroportA = db.Column(db.Integer, db.ForeignKey("aeroport.code"))
    
    __table_args__ = (
        db.CheckConstraint("codeAeroportA != codeAeroportD"),
    )
    
    aeroport_depart = db.relationship("Aeroport", foreign_keys=[codeAeroportD], back_populates="vols_depart")
    aeroport_arrivee = db.relationship("Aeroport", foreign_keys=[codeAeroportA], back_populates="vols_arrivee")

def get_all_vols():
    return Vol.query.all()

def get_all_aeroports():
    return Aeroport.query.all()

def create_vol(compagnie, tempsD, terminalD, codeAeroportD, tempsA, terminalA, codeAeroportA):
    tempsD_obj = datetime.fromisoformat(tempsD.replace('Z', '+00:00'))
    tempsA_obj = datetime.fromisoformat(tempsA.replace('Z', '+00:00'))
    
    vol = Vol(
        compagnie=compagnie,
        tempsD=tempsD_obj,
        terminalD=terminalD,
        codeAeroportD=codeAeroportD,
        tempsA=tempsA_obj,
        terminalA=terminalA,
        codeAeroportA=codeAeroportA
    )
    db.session.add(vol)
    db.session.commit()
    return vol
