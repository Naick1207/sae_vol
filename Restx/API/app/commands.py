from .extensions import db
from .models import Aeroport, Vol
from .myapp import app
from datetime import datetime

@app.cli.command()
def syncdb():
    db.create_all()
    
    # Nettoyage des tables existantes
    db.session.query(Vol).delete()
    db.session.query(Aeroport).delete()
    
    # --- AÉROPORTS ---
    aeroport1 = Aeroport(code=456, nom="Antonio Carlos", pays="Brésil", ville="Rio de Janeiro")
    aeroport2 = Aeroport(code=123, nom="Charles de Gaulle", pays="France", ville="Paris")
    aeroport3 = Aeroport(code=100, nom="Charles de Gaulle", pays="France", ville="Paris")
    aeroport4 = Aeroport(code=200, nom="Schiphol", pays="Pays-Bas", ville="Amsterdam")
    aeroport5 = Aeroport(code=300, nom="Barajas", pays="Espagne", ville="Madrid")
    aeroport6 = Aeroport(code=400, nom="Fiumicino", pays="Italie", ville="Rome")
    aeroport7 = Aeroport(code=500, nom="Heathrow", pays="Royaume-Uni", ville="Londres")
    aeroport8 = Aeroport(code=600, nom="Tegel", pays="Allemagne", ville="Berlin")
    aeroport9 = Aeroport(code=700, nom="John F Kennedy", pays="USA", ville="New York")
    
    # --- VOLS ---
    vol1 = Vol(compagnie="AirFrance",
              tempsD=datetime.strptime("12/02/2026 12:34:56", "%d/%m/%Y %H:%M:%S"),
              terminalD="1", codeAeroportD=123,
              tempsA=datetime.strptime("14/02/2026 14:42:23", "%d/%m/%Y %H:%M:%S"),
              terminalA="2E", codeAeroportA=456)
    
    vol2 = Vol(compagnie="AirFrance",
              tempsD=datetime.strptime("10/03/2026 08:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="2A", codeAeroportD=100,
              tempsA=datetime.strptime("10/03/2026 09:30:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="B", codeAeroportA=200)
    
    vol3 = Vol(numero=2, compagnie="AirFrance",
              tempsD=datetime.strptime("10/03/2026 07:45:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="2B", codeAeroportD=100,
              tempsA=datetime.strptime("10/03/2026 10:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="T1", codeAeroportA=300)
    
    vol4 = Vol(numero=3, compagnie="Alitalia",
              tempsD=datetime.strptime("10/03/2026 09:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="1C", codeAeroportD=100,
              tempsA=datetime.strptime("10/03/2026 11:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="T3", codeAeroportA=400)
    
    vol5 = Vol(numero=4, compagnie="KLM",
              tempsD=datetime.strptime("10/03/2026 11:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="C", codeAeroportD=200,
              tempsA=datetime.strptime("10/03/2026 12:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="5", codeAeroportA=500)
    
    vol6 = Vol(numero=5, compagnie="Iberia",
              tempsD=datetime.strptime("10/03/2026 12:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="T2", codeAeroportD=300,
              tempsA=datetime.strptime("10/03/2026 14:30:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="A", codeAeroportA=600)
    
    vol7 = Vol(numero=6, compagnie="BritishAirways",
              tempsD=datetime.strptime("10/03/2026 15:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalD="5", codeAeroportD=500,
              tempsA=datetime.strptime("10/03/2026 22:00:00", "%d/%m/%Y %H:%M:%S"),
              terminalA="4", codeAeroportA=700)
    
    # Ajout individuel comme dans ton exemple
    db.session.add(aeroport1)
    db.session.add(aeroport2)
    db.session.add(aeroport3)
    db.session.add(aeroport4)
    db.session.add(aeroport5)
    db.session.add(aeroport6)
    db.session.add(aeroport7)
    db.session.add(aeroport8)
    db.session.add(aeroport9)
    
    db.session.add(vol1)
    db.session.add(vol2)
    db.session.add(vol3)
    db.session.add(vol4)
    db.session.add(vol5)
    db.session.add(vol6)
    db.session.add(vol7)
    
    db.session.commit()
