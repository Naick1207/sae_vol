class Vol {
  final int numero;
  final String compagnie;
  final String tempsD;
  final String terminalD;
  final String aeroportD;
  final String tempsA;
  final String terminalA;
  final String aeroportA;
  final int codeAeroportD;
  final int codeAeroportA;

  const Vol({required this.numero,
    required this.compagnie,
    required this.tempsD,
    required this.terminalD,
    required this.aeroportD,
    required this.tempsA,
    required this.terminalA,
    required this.aeroportA,
    required this.codeAeroportD,
    required this.codeAeroportA, });

  factory Vol.fromJson(Map<String, dynamic> json){
    return switch(json){
    {'numero': int numero,
    'compagnie': String compagnie,
    'tempsD': String tempsD,
    'terminalD': String terminalD,
    'aeroportD': String aeroportD,
    'tempsA': String tempsA,
    'terminalA': String terminalA,
    'aeroportA': String aeroportA,
    'codeAeroportD': int codeAeroportD,
    'codeAeroportA': int codeAeroportA} => Vol(
      numero: numero,
      compagnie: compagnie,
      tempsD: tempsD,
      terminalD: terminalD,
      aeroportD: aeroportD,
      tempsA: tempsA,
      terminalA: terminalA,
      aeroportA: aeroportA,
      codeAeroportD: codeAeroportD,
      codeAeroportA: codeAeroportA
    ),
    _ => throw const FormatException('Ca marche pas =(')
    };
  }
}