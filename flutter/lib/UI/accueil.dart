import 'package:flutter/material.dart';
import 'package:sae_vol/resources/json.dart';
import '../API/Aeroport.dart';
import '../API/Vol.dart';

class CardAccueil extends StatelessWidget {
  const CardAccueil({required this.titre, required this.chiffre});
  final String titre;
  final String chiffre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(titre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(chiffre, style: const TextStyle(fontSize: 65))
        ],
      ),
    );
  }
}

class Accueil extends StatelessWidget{
  const Accueil({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(15),
        child: const Text("Bienvenue sur Wilson Compagnie", textAlign: TextAlign.start, style: TextStyle(fontSize: 45, color: Colors.white))),
        SizedBox(height: 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<Aeroport>>(
              future: getAeroports(),
              builder: (context, snapshot){
                String label = snapshot.hasData ? snapshot.data!.length.toString() : "...";
                return Card.filled(
                  child: CardAccueil(titre: "Nombre d'aéroports", chiffre: label)
                );
              },
            ),
            SizedBox(width: 40),
            FutureBuilder<List<Vol>>(
              future: getVols(),
              builder: (context, snapshot) {
                String label = snapshot.hasData ? snapshot.data!.length.toString() : "...";
                return Card.filled(
                  child: CardAccueil(titre: "Nombre de vols", chiffre: label)
                );
              },
            ),
          ],
        )
      ],
    );
  }
}