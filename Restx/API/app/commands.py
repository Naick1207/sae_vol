from .extensions import db
from .models import Aeroport, Vol
from .myapp import app

@app.cli.command()
def syncdb():
    with app.app_context():
        db.drop_all()
        db.create_all()
        
        aeroports = [
            (100, "Charles de Gaulle", "France", "Paris"),
            (200, "Schiphol", "Pays-Bas", "Amsterdam"),
            (300, "Barajas", "Espagne", "Madrid"),
            (400, "Fiumicino", "Italie", "Rome"),
            (500, "Heathrow", "Royaume-Uni", "Londres"),
            (600, "Tegel", "Allemagne", "Berlin"),
            (700, "John F Kennedy", "USA", "New York"),
            (800, "Los Angeles International", "USA", "Los Angeles"),
            (900, "Dubai International", "Emirats Arabes Unis", "Dubai"),
            (1000, "Tokyo Haneda", "Japon", "Tokyo"),
            (1100, "Singapore Changi", "Singapour", "Singapour"),
            (1200, "Sydney Kingsford Smith", "Australie", "Sydney"),
            (1300, "Beijing Capital", "Chine", "Beijing"),
            (1400, "Delhi Indira Gandhi", "Inde", "Delhi"),
            (1500, "São Paulo Guarulhos", "Brésil", "São Paulo"),
            (1600, "Mexico City International", "Mexique", "Mexico City"),
            (1700, "Toronto Pearson", "Canada", "Toronto"),
            (1800, "Frankfurt Main", "Allemagne", "Francfort"),
            (1900, "Zurich", "Suisse", "Zurich"),
            (2000, "Copenhagen", "Danemark", "Copenhague"),
            (2100, "Stockholm Arlanda", "Suède", "Stockholm"),
            (2200, "Oslo Gardermoen", "Norvège", "Oslo"),
            (2300, "Helsinki Vantaa", "Finlande", "Helsinki"),
            (2400, "Vienne", "Autriche", "Vienne"),
            (2500, "Prague Václav Havel", "République Tchèque", "Prague"),
            (2600, "Varsovie Chopin", "Pologne", "Varsovie"),
            (2700, "Budapest Ferenc Liszt", "Hongrie", "Budapest"),
            (2800, "Athènes Elefthérios Venizélos", "Grèce", "Athènes"),
            (2900, "Lisbonne Humberto Delgado", "Portugal", "Lisbonne"),
            (3000, "Dublin", "Irlande", "Dublin")
        ]
        
        for data in aeroports:
            db.session.add(Aeroport(code=data[0], nom=data[1], pays=data[2], ville=data[3]))
        
        vols = [
            (101, "AirFrance", "2026-03-10T06:00:00", "2A", 100, "2026-03-10T07:30:00", "B", 200),
            (102, "AirFrance", "2026-03-10T07:00:00", "2B", 100, "2026-03-10T08:30:00", "T1", 300),
            (103, "AirFrance", "2026-03-10T08:00:00", "2C", 100, "2026-03-10T10:00:00", "T3", 400),
            (104, "AirFrance", "2026-03-10T09:00:00", "2D", 100, "2026-03-10T10:30:00", "5", 500),
            (105, "AirFrance", "2026-03-10T10:00:00", "2E", 100, "2026-03-10T11:30:00", "A", 600),
            (106, "AirFrance", "2026-03-10T11:00:00", "2F", 100, "2026-03-10T12:30:00", "1", 1800),
            (107, "AirFrance", "2026-03-10T12:00:00", "2G", 100, "2026-03-10T13:30:00", "B", 1900),
            (108, "AirFrance", "2026-03-10T14:00:00", "2H", 100, "2026-03-10T15:30:00", "C", 2000),
            (109, "AirFrance", "2026-03-10T16:00:00", "2I", 100, "2026-03-10T17:30:00", "D", 2100),
            (201, "KLM", "2026-03-10T08:30:00", "C", 200, "2026-03-10T09:30:00", "5", 500),
            (202, "KLM", "2026-03-10T10:00:00", "D", 200, "2026-03-10T11:00:00", "T2", 300),
            (203, "KLM", "2026-03-10T11:30:00", "E", 200, "2026-03-10T12:30:00", "T3", 400),
            (204, "KLM", "2026-03-10T13:00:00", "F", 200, "2026-03-10T14:00:00", "A", 600),
            (205, "KLM", "2026-03-10T14:30:00", "G", 200, "2026-03-10T15:30:00", "1", 1800),
            (301, "BritishAirways", "2026-03-10T07:00:00", "5", 500, "2026-03-10T08:30:00", "4", 700),
            (302, "BritishAirways", "2026-03-10T09:00:00", "5", 500, "2026-03-10T10:30:00", "T1", 800),
            (303, "BritishAirways", "2026-03-10T11:00:00", "5", 500, "2026-03-10T12:30:00", "1", 900),
            (304, "BritishAirways", "2026-03-10T13:00:00", "5", 500, "2026-03-10T14:30:00", "2", 1000),
            (305, "BritishAirways", "2026-03-10T15:00:00", "5", 500, "2026-03-10T16:30:00", "3", 1100),
            (401, "Lufthansa", "2026-03-10T08:00:00", "1", 1800, "2026-03-10T09:30:00", "B", 200),
            (402, "Lufthansa", "2026-03-10T09:30:00", "1", 1800, "2026-03-10T11:00:00", "T3", 400),
            (403, "Lufthansa", "2026-03-10T11:00:00", "1", 1800, "2026-03-10T12:30:00", "5", 500),
            (404, "Lufthansa", "2026-03-10T12:30:00", "1", 1800, "2026-03-10T14:00:00", "2A", 100),
            (405, "Lufthansa", "2026-03-10T14:00:00", "1", 1800, "2026-03-10T15:30:00", "T1", 300),
            (501, "Emirates", "2026-03-10T02:00:00", "1", 900, "2026-03-10T06:00:00", "2A", 100),
            (502, "Emirates", "2026-03-10T03:00:00", "1", 900, "2026-03-10T07:00:00", "5", 500),
            (503, "Emirates", "2026-03-10T04:00:00", "1", 900, "2026-03-10T08:00:00", "4", 700),
            (504, "Emirates", "2026-03-10T05:00:00", "1", 900, "2026-03-10T09:00:00", "T1", 800),
            (601, "Delta", "2026-03-10T18:00:00", "4", 700, "2026-03-10T19:30:00", "T1", 800),
            (602, "Delta", "2026-03-10T20:00:00", "4", 700, "2026-03-10T21:30:00", "2A", 100),
            (603, "Delta", "2026-03-10T22:00:00", "4", 700, "2026-03-10T23:30:00", "5", 500),
            (701, "JapanAirlines", "2026-03-10T10:00:00", "2", 1000, "2026-03-10T14:00:00", "1", 900),
            (702, "JapanAirlines", "2026-03-10T11:00:00", "2", 1000, "2026-03-10T15:00:00", "4", 700),
            (703, "JapanAirlines", "2026-03-10T12:00:00", "2", 1000, "2026-03-10T16:00:00", "2A", 100),
            (801, "Iberia", "2026-03-10T09:00:00", "T2", 300, "2026-03-10T10:30:00", "T3", 400),
            (802, "Iberia", "2026-03-10T11:00:00", "T2", 300, "2026-03-10T12:30:00", "5", 500),
            (803, "Alitalia", "2026-03-10T10:30:00", "T3", 400, "2026-03-10T12:00:00", "A", 600),
            (804, "Swiss", "2026-03-10T12:00:00", "B", 1900, "2026-03-10T13:30:00", "1", 1800),
            (805, "SAS", "2026-03-10T13:30:00", "C", 2000, "2026-03-10T15:00:00", "5", 500),
            (1101, "AirFrance", "2026-03-11T06:30:00", "2A", 200, "2026-03-11T08:00:00", "2A", 100),
            (1102, "AirFrance", "2026-03-11T07:30:00", "T1", 300, "2026-03-11T09:00:00", "2B", 100),
            (1103, "AirFrance", "2026-03-11T09:30:00", "T3", 400, "2026-03-11T11:30:00", "2C", 100),
            (1104, "BritishAirways", "2026-03-11T08:00:00", "4", 700, "2026-03-11T09:30:00", "5", 500),
            (1105, "BritishAirways", "2026-03-11T10:00:00", "T1", 800, "2026-03-11T11:30:00", "5", 500),
            (1106, "Lufthansa", "2026-03-11T07:00:00", "B", 200, "2026-03-11T08:30:00", "1", 1800),
            (1107, "Lufthansa", "2026-03-11T09:00:00", "T3", 400, "2026-03-11T10:30:00", "1", 1800)
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
