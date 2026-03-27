class Aeroport {

  final int code;
  final String nom;
  final String pays;
  final String ville;

  const Aeroport({
    required this.code,
    required this.nom,
    required this.pays,
    required this.ville,
});

  factory Aeroport.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'code': int code,
        'nom': String nom,
        'pays': String pays,
        'ville': String ville
    } => Aeroport(
        code: code,
        nom: nom,
        pays: pays,
        ville: ville
      ),
      _ => throw const FormatException('Ca marche pas =(')
    };
  }
}