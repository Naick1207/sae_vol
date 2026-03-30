import 'package:flutter/material.dart';

class Style {
  // Définit les couleurs pour le menu à gauche
  static final styleMenu = ListTileThemeData(
    selectedColor: Colors.lightBlueAccent,
    textColor: Colors.white,
    selectedTileColor: Colors.black,
  );

  // Définit les couleurs et la taille de police des éléments apparaissant avec les ListView (vols, aéroports...)
  static final styleElement = ListTileThemeData(
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
    subtitleTextStyle: const TextStyle(color: Colors.white60, fontSize: 14),
    leadingAndTrailingTextStyle: const TextStyle(color: Colors.white60, fontSize: 14),
  );

  // Définit le style des toggleButtons, permettant d'indiquer si la recherche se fait sur le départ, l'arrivée ou les 2 sur les vols et les vols avec correspondances
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

  // Définit la couleur utilisée pour le fond de la page
  static final couleurFond = Colors.blue[900];

  // Définit la couleur utilisée lorsqu'une option est sélectionnée
  static final couleurMenu = Color(0xAB000000);

  // Définit la couleur utilisée lorsque l'on veut afficher un titre
  static final couleurTitre = Colors.white;

  // Définit la couleur de fond des barres de recherche
  static final couleurBarreRecherche = Colors.white;

  // Définit l'apparence de l'animation lorsque les données sont en train de charger (le cercle qui tourne)
  static final chargement = Center(child: CircularProgressIndicator(color: Colors.lightBlueAccent));
}