import 'package:flutter/material.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Accueil(),
    const Vols(),
    const Correspondances(),
    const Aeroports(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Row(
        children: [
          Container(
            width: 200,
            color: Color(0xAB000000),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Accueil"),
                  selected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                  selectedColor: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  selectedTileColor: Colors.black45,
                ),
                ListTile(
                  title: const Text("Vols directs"),
                  selected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                  selectedColor: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  selectedTileColor: Colors.black45,
                ),
                ListTile(
                  title: const Text("Vols avec correspondances"),
                  selected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                  selectedColor: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  selectedTileColor: Colors.black45,
                ),
                ListTile(
                  title: const Text("Aéroports"),
                  selected: _selectedIndex == 3,
                  onTap: () => setState(() => _selectedIndex = 3),
                  selectedColor: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  selectedTileColor: Colors.black45,
                ),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex], //affiche la page sélectionnée
          ),
        ],
      ),
    );
  }
}