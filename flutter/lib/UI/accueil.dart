import 'package:flutter/material.dart';

class Accueil extends StatelessWidget{
  const Accueil({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(15),
        child:
        const Text("Accueil de Wilson Compagnie", textAlign: TextAlign.start, style: TextStyle(fontSize: 45))),
      ],
    );
  }
}