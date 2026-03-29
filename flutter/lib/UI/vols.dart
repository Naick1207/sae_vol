import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../API/Vol.dart';
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

class Vols extends StatefulWidget {
  const Vols({super.key});

  @override
  State<Vols> createState() => _VolsState();
}

class _VolsState extends State<Vols> {
  final SearchController _searchController = SearchController();
  List<Vol> _allVols = [];
  List<Vol> _filteredVols = [];
  late Future<List<Vol>> _futureVols;

  @override
  void initState() {
    super.initState();
    _futureVols = getVols();
  }

  void onSearchChanged(String query) {
    setState(() {
      _filteredVols = _allVols.where((vol) {
        final q = query.toLowerCase();
        return (choixActuel <= 1 ? vol.aeroportDepart?.ville.toLowerCase().contains(q) == true || vol.aeroportDepart?.pays.toLowerCase().contains(q) == true : false) ||
               (choixActuel >= 1 ? vol.aeroportArrivee?.ville.toLowerCase().contains(q) == true || vol.aeroportArrivee?.pays.toLowerCase().contains(q) == true : false);
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
          future: _futureVols,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Text("Ca marche pas :( : ${snapshot.error}");
            }

            if (_allVols.isEmpty) {
              _allVols = snapshot.data!;
              _filteredVols = _allVols;
            }

            return _filteredVols.isEmpty
              ? const Center(child: Text("Aucun vol trouvé :("))
              : Expanded(
                child: ListView.builder(
                  itemCount: _filteredVols.length,
                  itemBuilder: (context, index) {
                    final vol = _filteredVols[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(vol.numero.toString()),
                      ),
                      title: Text('${vol.aeroportDepart?.ville} (${vol.aeroportD}) -> ${vol.aeroportArrivee?.ville} (${vol.aeroportA})', style: TextStyle(color: Colors.white)),
                      subtitle: Text('${vol.compagnie} | Départ: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsD)} (T${vol.terminalD}) | Arrivée: ${DateFormat("dd/MM/yyyy HH:mm").format(vol.tempsA)} (T${vol.terminalA})', style: TextStyle(color: Colors.white60)),
                      trailing: Text('${vol.codeAeroportD} -> ${vol.codeAeroportA}', style: TextStyle(color: Colors.white60)),
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