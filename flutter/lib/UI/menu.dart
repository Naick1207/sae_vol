import 'package:flutter/material.dart';
import 'accueil.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Accueil(),
    const Center(child: Text("Vols")),
    const Center(child: Text("Correspondances")),
    const Center(child: Text("Aéroports")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.grey[100],
            child: Column(
              children: [
                ListTile(
                  title: const Text("Accueil"),
                  selected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                ListTile(
                  title: const Text("Vols"),
                  selected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                ListTile(
                  title: const Text("Correspondances"),
                  selected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                ListTile(
                  title: const Text("Aéroports"),
                  selected: _selectedIndex == 3,
                  onTap: () => setState(() => _selectedIndex = 3),
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