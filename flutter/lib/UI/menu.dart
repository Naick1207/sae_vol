import 'package:flutter/material.dart';

var menu = Scaffold(
  body: Row(
    children: [
      Container(
        width: 200,
        color: Colors.grey[100],
        child: Column(
          children: [
            ListTile(
              title: Text("Accueil"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Vols"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Correspondances"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Aéroports"),
              onTap: () {},
            ),
          ],
        ),
      ),

      VerticalDivider(width: 1),

      Expanded(
        child: Center(
          child: Text("Contenu ici"),
        ),
      ),
    ],
  ),
);
