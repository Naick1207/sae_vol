import 'Aeroport.dart';
import '../resources/json.dart';
import 'package:intl/intl.dart';

class Vol {
  final int numero;
  final String compagnie;
  final DateTime tempsD;
  final String terminalD;
  DateTime tempsA;
  String terminalA;
  final int codeAeroportD;
  int codeAeroportA;

  Aeroport? aeroportDepart;
  Aeroport? aeroportArrivee;

  Vol({required this.numero,
    required this.compagnie,
    required this.tempsD,
    required this.terminalD,
    required this.tempsA,
    required this.terminalA,
    required this.codeAeroportD,
    required this.codeAeroportA,
    this.aeroportDepart,
    this.aeroportArrivee
  });

  Future<void> chargerAeroports() async {
    aeroportDepart = await getAeroport(codeAeroportD);
    aeroportArrivee = await getAeroport(codeAeroportA);
  }

  factory Vol.fromJson(Map<String, dynamic> json){
    return switch(json){
    {'numero': int numero,
    'compagnie': String compagnie,
    'tempsD': String tempsD,
    'terminalD': String terminalD,
    'tempsA': String tempsA,
    'terminalA': String terminalA,
    'codeAeroportD': int codeAeroportD,
    'codeAeroportA': int codeAeroportA} => Vol(
      numero: numero,
      compagnie: compagnie,
      tempsD: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(tempsD),
      terminalD: terminalD,
      tempsA: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(tempsA),
      terminalA: terminalA,
      codeAeroportD: codeAeroportD,
      codeAeroportA: codeAeroportA
    ),
    _ => throw const FormatException('Ca marche pas :(')
    };
  }
}