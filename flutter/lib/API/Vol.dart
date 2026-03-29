import 'Aeroport.dart';
import '../resources/json.dart';
import 'package:intl/intl.dart';

class Vol {
  final int numero;
  final String compagnie;
  final DateTime tempsD;
  final String terminalD;
  final String aeroportD;
  DateTime tempsA;
  String terminalA;
  String aeroportA;
  final int codeAeroportD;
  int codeAeroportA;

  Aeroport? aeroportDepart;
  Aeroport? aeroportArrivee;

  Vol({required this.numero,
    required this.compagnie,
    required this.tempsD,
    required this.terminalD,
    required this.aeroportD,
    required this.tempsA,
    required this.terminalA,
    required this.aeroportA,
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
    'aeroportD': String aeroportD,
    'tempsA': String tempsA,
    'terminalA': String terminalA,
    'aeroportA': String aeroportA,
    'codeAeroportD': int codeAeroportD,
    'codeAeroportA': int codeAeroportA} => Vol(
      numero: numero,
      compagnie: compagnie,
      tempsD: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(tempsD),
      terminalD: terminalD,
      aeroportD: aeroportD,
      tempsA: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(tempsA),
      terminalA: terminalA,
      aeroportA: aeroportA,
      codeAeroportD: codeAeroportD,
      codeAeroportA: codeAeroportA
    ),
    _ => throw const FormatException('Ca marche pas :(')
    };
  }
}