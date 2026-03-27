import 'dart:convert';

import 'package:http/http.dart' as http;
import '../API/Vol.dart';

const lien = 'http://localhost:5000';

Future<List<Vol>> getVols() async{
  final response = await http.get(
    Uri.parse('$lien/Vols'),
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