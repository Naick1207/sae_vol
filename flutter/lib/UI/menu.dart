import 'package:flutter/material.dart';
import 'styles.dart';
import 'accueil.dart';
import 'vols.dart';
import 'aeroports.dart';
import 'correspondances.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _indexCourant = 0;

  final List<Widget> _pages = [
    const Accueil(),
    const Vols(),
    const Correspondances(),
    const Aeroports(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.couleurFond,
      body: Row(
        children: [
          Container(
            width: 200,
            color: Style.couleurMenu,
            child: ListTileTheme(
              data: Style.styleMenu,
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Accueil"),
                    selected: _indexCourant == 0,
                    onTap: () => setState(() => _indexCourant = 0),
                  ),
                  ListTile(
                    title: const Text("Vols directs"),
                    selected: _indexCourant == 1,
                    onTap: () => setState(() => _indexCourant = 1),
                  ),
                  ListTile(
                    title: const Text("Vols avec correspondances"),
                    selected: _indexCourant == 2,
                    onTap: () => setState(() => _indexCourant = 2),
                  ),
                  ListTile(
                    title: const Text("Aéroports"),
                    selected: _indexCourant == 3,
                    onTap: () => setState(() => _indexCourant = 3),
                  ),
                ],
              ),
            )
          ),
          Expanded(
            child: _pages[_indexCourant], //affiche la page sélectionnée
          ),
        ],
      ),
    );
  }
}