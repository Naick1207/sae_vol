import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../API/Vol.dart';
import '../API/Correspondance.dart';
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

// Donne les détails sur les correspondances lorsque l'on clique sur un vol dans la liste
class DetailCorrespondance extends StatelessWidget {
  final Correspondance correspondance;

  const DetailCorrespondance({super.key, required this.correspondance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.couleurFond,
      appBar: AppBar(
        title: Text('${correspondance.aeroportDepart?.ville} (${correspondance.aeroportDepart?.nom}) -> ${correspondance.aeroportArrivee?.ville} (${correspondance.aeroportArrivee?.nom}) | Correspondances : ${correspondance.vols.length}'),
        centerTitle: true,
        backgroundColor: Style.couleurMenu,
        foregroundColor: Style.couleurTitre,
      ),
      body: ListTileTheme(
        data: Style.styleElement,
        child: ListView.builder(
          itemCount: correspondance.vols.length,
          itemBuilder: (context, index) {
            final vol = correspondance.vols[index];
            return ListTile(
                title: Text('${vol.aeroportDepart?.ville} (${vol.aeroportDepart?.nom}) -> ${vol.aeroportArrivee?.ville} (${vol.aeroportArrivee?.nom})'),
                subtitle: Text('${vol.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsD)} (T${vol.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsA)} (T${vol.terminalA})'),
                trailing: Text('${vol.codeAeroportD} -> ${vol.codeAeroportA}')
            );
          }
        )
      )
    );
  }
}

class Correspondances extends StatefulWidget {
  const Correspondances({super.key});

  @override
  State<Correspondances> createState() => _CorrespondancesState();
}

class _CorrespondancesState extends State<Correspondances> {
  final SearchController _controllerRecherche = SearchController();
  List<Correspondance> _lesCorrespondances = [];
  List<Correspondance> _filtrerCorrespondances = [];
  List<Vol> _lesVols = [];
  late Future<List<Vol>> _futureCorrespondances;

  @override
  void initState() {
    super.initState();
    _futureCorrespondances = getVols();
  }

  void rechercheChanged(String query) {
    setState(() {
      _filtrerCorrespondances = _lesCorrespondances.where((vol) {
        final q = query.toLowerCase();
        return (choixActuel <= 1 ? vol.contientDepart(q) : false) ||
            (choixActuel >= 1 ? vol.contientArrivee(q) : false);
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
          future: _futureCorrespondances,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Style.chargement;
            }
            if(snapshot.hasError){
              return Text("Ca marche pas :( : ${snapshot.error}");
            }

            if (_lesCorrespondances.isEmpty) {
              _lesVols = snapshot.data!;
              _lesCorrespondances = Correspondance.genererCorrespondances(_lesVols);
              _filtrerCorrespondances = _lesCorrespondances;
            }

            return _filtrerCorrespondances.isEmpty
              ? const Center(child: Text("Aucun vol trouvé :("))
              : Expanded(
              child: ListTileTheme(
                data: Style.styleElement,
                child: ListView.builder(
                  itemCount: _filtrerCorrespondances.length,
                  itemBuilder: (context, index) {
                    final correspondance = _filtrerCorrespondances[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(correspondance.numero.toString()),
                      ),
                      title: Text('${correspondance.aeroportDepart?.ville} (${correspondance.aeroportDepart?.nom}) -> ${correspondance.aeroportArrivee?.ville} (${correspondance.aeroportArrivee?.nom})'),
                      subtitle: Text('${correspondance.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(correspondance.tempsD)} (T${correspondance.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(correspondance.tempsA)} (T${correspondance.terminalA})'),
                      trailing: Text('${correspondance.codeAeroportD} -> ${correspondance.codeAeroportA}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailCorrespondance(correspondance: correspondance))
                        );
                      }
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