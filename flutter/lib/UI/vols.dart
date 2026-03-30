import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../API/Vol.dart';
import '../resources/json.dart';
import 'styles.dart';

// La liste des choix pour la recherche, définissant la méthode de recherche,
// le "&" recherche sur l'aéroport de départ & d'arrivée, et est celui qui est activé de base
const List<Widget> choix = <Widget>[
  Text("Départ"),
  Text("&"),
  Text("Arrivée"),
];

var choixActuel = 1;

class ChoixVille extends StatefulWidget {
  final VoidCallback onChoixChanged;

  const ChoixVille({super.key, required this.onChoixChanged});

  @override
  State<ChoixVille> createState() => _ChoixVilleState();
}

class _ChoixVilleState extends State<ChoixVille> {
  final List<bool> _choix = [false, true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtonsTheme(
      data: Style.styleToggleButton,
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _choix.length; i++) {
              _choix[i] = i == index;
            }
            choixActuel = index;
          });
          widget.onChoixChanged();
        },
        isSelected: _choix,
        children: choix,
      )
    );
  }
}

class Vols extends StatefulWidget {
  const Vols({super.key});

  @override
  State<Vols> createState() => _VolsState();
}

class _VolsState extends State<Vols> {
  final SearchController _controllerRecherche = SearchController();
  List<Vol> _lesVols = [];
  List<Vol> _filtrerVols = [];
  late Future<List<Vol>> _futureVols;

  @override
  void initState() {
    super.initState();
    _futureVols = getVols();
  }

  void rechercheChanged(String query) {
    setState(() {
      _filtrerVols = _lesVols.where((vol) {
        final q = query.toLowerCase();
        return (choixActuel <= 1 ? vol.aeroportDepart?.ville.toLowerCase().contains(q) == true || vol.aeroportDepart?.pays.toLowerCase().contains(q) == true : false) ||
               (choixActuel >= 1 ? vol.aeroportArrivee?.ville.toLowerCase().contains(q) == true || vol.aeroportArrivee?.pays.toLowerCase().contains(q) == true : false);
      }).toList();
    });
  }

  void _onChoixChanged() {
    rechercheChanged(_controllerRecherche.text);
  }

  @override
  void dispose() {
    _controllerRecherche.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 25),
        Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              child: SearchBar(
                controller: _controllerRecherche,
                leading: const Icon(Icons.search),
                hintText: "Recherchez une ville ou un pays",
                backgroundColor: WidgetStateProperty.all(Style.couleurBarreRecherche),
                onChanged: rechercheChanged,
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(width: 10),
            ChoixVille(onChoixChanged: _onChoixChanged),
            SizedBox(width: 10),
          ]
        ),
        SizedBox(height: 15),
        FutureBuilder(
          future: _futureVols,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Style.chargement;
            }
            if(snapshot.hasError){
              return Text("Ca marche pas :( : ${snapshot.error}");
            }

            if (_lesVols.isEmpty) {
              _lesVols = snapshot.data!;
              _filtrerVols = _lesVols;
            }

            return _filtrerVols.isEmpty
              ? const Center(child: Text("Aucun vol trouvé :("))
              : Expanded(
                child: ListTileTheme(
                  data: Style.styleElement,
                  child: ListView.builder(
                    itemCount: _filtrerVols.length,
                    itemBuilder: (context, index) {
                      final vol = _filtrerVols[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(vol.numero.toString()),
                        ),
                        title: Text('${vol.aeroportDepart?.ville} (${vol.aeroportDepart?.nom}) -> ${vol.aeroportArrivee?.ville} (${vol.aeroportArrivee?.nom})'),
                        subtitle: Text('${vol.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsD)} (T${vol.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsA)} (T${vol.terminalA})'),
                        trailing: Text('${vol.codeAeroportD} -> ${vol.codeAeroportA}'),
                      );
                    },
                  )
                )
              );
          }
        )
      ]
    );
  }
}