import 'package:flutter/material.dart';
import '../API/Aeroport.dart';
import '../resources/json.dart';
import 'styles.dart';

class Aeroports extends StatefulWidget{
  const Aeroports({super.key});

  @override
  State<Aeroports> createState() => _AeroportsState();
}

class _AeroportsState extends State<Aeroports> {
  final SearchController _controllerRecherche = SearchController();
  List<Aeroport> _lesAeroports = [];
  List<Aeroport> _filtrerAeroports = [];
  late Future<List<Aeroport>> _futureAeroports;

  @override
  void initState() {
    super.initState();
    _futureAeroports = getAeroports();
  }

  void _rechercheChanged(String query) {
    setState(() {
      _filtrerAeroports = _lesAeroports.where((aeroport) {
        final q = query.toLowerCase();
        return aeroport.ville.toLowerCase().contains(q) == true ||
            aeroport.nom.toLowerCase().contains(q) == true ||
            aeroport.pays.toLowerCase().contains(q) == true;
      }).toList();
    });
  }

  @override
  void dispose() {
    _controllerRecherche.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SearchBar(
            controller: _controllerRecherche,
            leading: const Icon(Icons.search),
            hintText: "Recherchez un nom d'aéroport, une ville ou un pays",
            backgroundColor: WidgetStateProperty.all(Style.couleurBarreRecherche),
            onChanged: _rechercheChanged,
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          )
        ),
        SizedBox(height: 15),
        FutureBuilder(
          future: _futureAeroports,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Style.chargement;
            }
            if(snapshot.hasError){
              return Text("Ca marche pas :( : ${snapshot.error}");
            }

            if (_lesAeroports.isEmpty) {
              _lesAeroports = snapshot.data!;
              _filtrerAeroports = _lesAeroports;
            }

            return _filtrerAeroports.isEmpty
              ? const Center(child: Text("Aucun aéroport trouvé :("))
              : Expanded(
                child: ListTileTheme(
                  data: Style.styleElement,
                  child: ListView.builder (
                    itemCount: _filtrerAeroports.length,
                    itemBuilder: (context, index) {
                      final aeroport = _filtrerAeroports[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(aeroport.code.toString()),
                        ),
                        title: Text(aeroport.nom),
                        subtitle: Text('${aeroport.ville}, ${aeroport.pays}'),
                        trailing: Text('${aeroport.code}'),
                      );
                    },
                  )
                )
              );
          }
        ),
      ]
    );
  }
}