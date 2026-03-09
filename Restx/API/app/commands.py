from .extensions import db
from .models import Aeroport, Vol
from .myapp import app

@app.cli.command()
def syncdb():
    with app.app_context():
        db.drop_all()
        db.create_all()
        
        aeroports = [
            (456, "Antonio Carlos", "Brésil", "Rio de Janeiro"),
            (123, "Charles de Gaulle", "France", "Paris"),
            (100, "Charles de Gaulle", "France", "Paris"),
            (200, "Schiphol", "Pays-Bas", "Amsterdam"),
            (300, "Barajas", "Espagne", "Madrid"),
            (400, "Fiumicino", "Italie", "Rome"),
            (500, "Heathrow", "Royaume-Uni", "Londres"),
            (600, "Tegel", "Allemagne", "Berlin"),
            (700, "John F Kennedy", "USA", "New York")
        ]
        
        for data in aeroports:
            db.session.add(Aeroport(code=data[0], nom=data[1], pays=data[2], ville=data[3]))
        
        vols = [
            (442, "AirFrance", "2026-02-12T12:34:56", "1", 123, "2026-02-14T14:42:23", "2E", 456),
            (1, "AirFrance", "2026-03-10T08:00:00", "2A", 100, "2026-03-10T09:30:00", "B", 200),
            (2, "AirFrance", "2026-03-10T07:45:00", "2B", 100, "2026-03-10T10:00:00", "T1", 300),
            (3, "Alitalia", "2026-03-10T09:00:00", "1C", 100, "2026-03-10T11:00:00", "T3", 400),
            (4, "KLM", "2026-03-10T11:00:00", "C", 200, "2026-03-10T12:00:00", "5", 500),
            (5, "Iberia", "2026-03-10T12:00:00", "T2", 300, "2026-03-10T14:30:00", "A", 600),
            (6, "BritishAirways", "2026-03-10T15:00:00", "5", 500, "2026-03-10T22:00:00", "4", 700)
        ]
        
        for vol_data in vols:
            db.session.add(Vol(
                numero=vol_data[0],
                compagnie=vol_data[1],
                tempsD=vol_data[2],
                terminalD=vol_data[3],
                codeAeroportD=vol_data[4],
                tempsA=vol_data[5],
                terminalA=vol_data[6],
                codeAeroportA=vol_data[7]
            ))
        
        db.session.commit()
        print(f"DB OK ! {Aeroport.query.count()} aéroports, {Vol.query.count()} vols")
