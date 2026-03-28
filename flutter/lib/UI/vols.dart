import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../API/Vol.dart';
import '../resources/json.dart';

class Vols extends StatelessWidget{
  const Vols({super.key});

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        future: getVols(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if(snapshot.hasError){
            return Text("Ca marche pas :( : ${snapshot.error}");
          }
          final vols = snapshot.data!;
          return ListView.builder(
            itemCount: vols.length,
            itemBuilder: (context, index) {
              final vol = vols[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(vol.numero.toString()),
                ),
                title: Text('${vol.aeroportD} -> ${vol.aeroportA}'),
                subtitle: Text('${vol.compagnie} | Départ: ${vol.tempsD} (T${vol.terminalD}) | Arrivée: ${vol.tempsA} (T${vol.terminalA})'),
                trailing: Text('${vol.codeAeroportD} -> ${vol.codeAeroportA}'),
              );
            },
          );
          }
        );
  }
}