import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../API/Vol.dart';
import '../API/Correspondance.dart';
import '../resources/json.dart';

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
    return ToggleButtons(
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
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.black,
      selectedColor: Colors.lightBlueAccent,
      borderColor: Colors.black,
      fillColor: Color(0xAB000000),
      color: Colors.black,
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _choix,
      children: choix,
    );
  }
}

class DetailCorrespondance extends StatelessWidget {
  final Correspondance correspondance;

  const DetailCorrespondance({super.key, required this.correspondance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('${correspondance.aeroportDepart?.ville} (${correspondance.aeroportD}) -> ${correspondance.aeroportArrivee?.ville} (${correspondance.aeroportA}) | Correspondances : ${correspondance.vols.length}'),
        centerTitle: true,
        backgroundColor: Color(0xAB000000),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: correspondance.vols.length,
        itemBuilder: (context, index) {
          final vol = correspondance.vols[index];
          return ListTile(
              title: Text('${vol.aeroportDepart?.ville} (${vol.aeroportD}) -> ${vol.aeroportArrivee?.ville} (${vol.aeroportA})', style: TextStyle(color: Colors.white)),
              subtitle: Text('${vol.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsD)} (T${vol.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsA)} (T${vol.terminalA})', style: TextStyle(color: Colors.white60)),
              trailing: Text('${vol.codeAeroportD} -> ${vol.codeAeroportA}', style: TextStyle(color: Colors.white60))
          );
        }
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
  final SearchController _searchController = SearchController();
  List<Correspondance> _allCorrespondances = [];
  List<Correspondance> _filteredCorrespondances = [];
  List<Vol> _allVols = [];
  late Future<List<Vol>> _futureCorrespondances;

  @override
  void initState() {
    super.initState();
    _futureCorrespondances = getVols();
  }

  void onSearchChanged(String query) {
    setState(() {
      _filteredCorrespondances = _allCorrespondances.where((vol) {
        final q = query.toLowerCase();
        return (choixActuel <= 1 ? vol.contientDepart(q) : false) ||
            (choixActuel >= 1 ? vol.contientArrivee(q) : false);
      }).toList();
    });
  }

  void _onChoixChanged() {
    onSearchChanged(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
                    controller: _searchController,
                    leading: const Icon(Icons.search),
                    hintText: "Recherchez une ville ou un pays",
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    onChanged: onSearchChanged,
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
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasError){
                  return Text("Ca marche pas :( : ${snapshot.error}");
                }

                if (_allCorrespondances.isEmpty) {
                  _allVols = snapshot.data!;
                  _allCorrespondances = Correspondance.genererCorrespondances(_allVols);
                  _filteredCorrespondances = _allCorrespondances;
                }

                return _filteredCorrespondances.isEmpty
                    ? const Center(child: Text("Aucun vol trouvé :("))
                    : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCorrespondances.length,
                      itemBuilder: (context, index) {
                        final correspondance = _filteredCorrespondances[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(correspondance.numero.toString()),
                          ),
                          title: Text('${correspondance.aeroportDepart?.ville} (${correspondance.aeroportD}) -> ${correspondance.aeroportArrivee?.ville} (${correspondance.aeroportA})', style: TextStyle(color: Colors.white)),
                          subtitle: Text('${correspondance.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(correspondance.tempsD)} (T${correspondance.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(correspondance.tempsA)} (T${correspondance.terminalA})', style: TextStyle(color: Colors.white60)),
                          trailing: Text('${correspondance.codeAeroportD} -> ${correspondance.codeAeroportA}', style: TextStyle(color: Colors.white60)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailCorrespondance(correspondance: correspondance))
                            );
                          }
                        );
                      },
                    )
                );
              }
          )
        ]
    );
  }
}