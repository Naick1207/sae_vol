import 'dart:convert';
import '../config.dart';
import 'package:http/http.dart' as http;
import '../API/Vol.dart';
import '../API/Aeroport.dart';

// Récupère les vols
Future<List<Vol>> getVols() async{
  final response = await http.get(
    Uri.parse('${Config.apiUrl}/api/Vols'),
    headers: {'Accept' : 'application/json'},
  );

  if(response.statusCode == 200){
    final List<dynamic> json = jsonDecode(response.body);
    final vols = <Vol> [];
    for(var vol in json){
      vols.add(Vol.fromJson(vol));
    }
    await Future.wait(
      vols.map((vol) => vol.chargerAeroports()),
    );
    return vols;
  }else{
    throw Exception('Ca a pas marché :(');
  }
}

// Récupère les aéroports
Future<List<Aeroport>> getAeroports() async{
  final response = await http.get(
    Uri.parse('${Config.apiUrl}/api/Aeroports'),
    headers: {'Accept' : 'application/json'},
  );

  if(response.statusCode == 200){
    final List<dynamic> json = jsonDecode(response.body);
    final aeroports = <Aeroport> [];
    for(var aeroport in json){
      aeroports.add(Aeroport.fromJson(aeroport));
    }
    return aeroports;
  }else{
    throw Exception('Ca a pas marché :(');
  }
}

// Récupère un aéroport selon son code (sert pour lier les vols avec leurs aéroports)
Future<Aeroport> getAeroport(int code) async{
  final response = await http.get(
    Uri.parse('${Config.apiUrl}/api/Aeroports/$code'),
    headers: {'Accept' : 'application/json'},
  );

  if(response.statusCode == 200){
    final dynamic json = jsonDecode(response.body);
    final aeroport = Aeroport.fromJson(json);
    return aeroport;
  } else {
    throw Exception('Ca a pas marché :(');
  }
}