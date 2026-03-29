import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../API/Aeroport.dart';
import '../resources/json.dart';

class Aeroports extends StatefulWidget{
  const Aeroports({super.key});

  @override
  State<Aeroports> createState() => _AeroportsState();
}

class _AeroportsState extends State<Aeroports> {
  final SearchController _searchController = SearchController();
  List<Aeroport> _allAeroports = [];
  List<Aeroport> _filteredAeroports = [];
  late Future<List<Aeroport>> _futureAeroports;

  @override
  void initState() {
    super.initState();
    _futureAeroports = getAeroports();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredAeroports = _allAeroports.where((aeroport) {
        final q = query.toLowerCase();
        return aeroport.ville.toLowerCase().contains(q) == true ||
            aeroport.nom.toLowerCase().contains(q) == true ||
            aeroport.pays.toLowerCase().contains(q) == true;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            controller: _searchController,
            leading: const Icon(Icons.search),
            hintText: "Recherchez un nom d'aéroport, une ville ou un pays",
            backgroundColor: WidgetStateProperty.all(Colors.white),
            onChanged: _onSearchChanged,
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          )
        ),
        SizedBox(height: 15),
        FutureBuilder(
          future: _futureAeroports,
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Text("Ca marche pas :( : ${snapshot.error}");
            }

            if (_allAeroports.isEmpty) {
              _allAeroports = snapshot.data!;
              _filteredAeroports = _allAeroports;
            }

            return _filteredAeroports.isEmpty
              ? const Center(child: Text("Aucun aéroport trouvé :("))
              : Expanded(
                child: ListView.builder (
                  itemCount: _filteredAeroports.length,
                  itemBuilder: (context, index) {
                    final aeroport = _filteredAeroports[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(aeroport.code.toString()),
                      ),
                      title: Text(aeroport.nom, style: TextStyle(color: Colors.white)),
                      subtitle: Text('${aeroport.ville}, ${aeroport.pays}', style: TextStyle(color: Colors.white60)),
                      trailing: Text('${aeroport.code}', style: TextStyle(color: Colors.white60)),
                    );
                  },
                )
              );
          }
        ),
      ]
    );
  }
}