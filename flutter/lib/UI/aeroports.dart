import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../API/Vol.dart';
import '../resources/json.dart';

class Aeroports extends StatelessWidget{
  const Aeroports({super.key});

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        future: getAeroports(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if(snapshot.hasError){
            return Text("Ca marche pas :( : ${snapshot.error}");
          }
          final aeroports = snapshot.data!;
          return ListView.builder(
            itemCount: aeroports.length,
            itemBuilder: (context, index) {
              final aeroport = aeroports[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(aeroport.code.toString()),
                ),
                title: Text(aeroport.nom),
                subtitle: Text('${aeroport.ville}, ${aeroport.pays}'),
                trailing: Text('${aeroport.code}'),
              );
            },
          );
          }
        );
  }
}