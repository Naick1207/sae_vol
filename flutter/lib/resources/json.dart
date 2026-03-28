import 'dart:convert';
import '../config.dart';
import 'package:http/http.dart' as http;
import '../API/Vol.dart';

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
    return vols;
  }else{
    throw Exception('Ca a pas marché :(');
  }
}