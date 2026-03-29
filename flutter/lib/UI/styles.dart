import 'package:flutter/material.dart';

class Style {
  static final styleMenu = ListTileThemeData(
    selectedColor: Colors.lightBlueAccent,
    textColor: Colors.white,
    selectedTileColor: Colors.black,
  );

  static final styleElement = ListTileThemeData(
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
    subtitleTextStyle: const TextStyle(color: Colors.white60, fontSize: 14),
    leadingAndTrailingTextStyle: const TextStyle(color: Colors.white60, fontSize: 14),
  );

  static final styleToggleButton = ToggleButtonsThemeData(
    selectedColor: Colors.lightBlueAccent,
    selectedBorderColor: Colors.black,
    borderColor: Colors.black,
    fillColor: Color(0xAB000000),
    color: Colors.black,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    constraints: BoxConstraints(
      minHeight: 40.0,
      minWidth: 80.0,
    ),
  );

  static final couleurFond = Colors.blue[900];

  static final couleurMenu = Color(0xAB000000);

  static final couleurTitre = Colors.white;

  static final couleurBarreRecherche = Colors.white;

  static final chargement = Center(child: CircularProgressIndicator(color: Colors.lightBlueAccent));
}