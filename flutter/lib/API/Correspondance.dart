import 'Vol.dart';

class Correspondance extends Vol {
  final List<Vol> vols = [];

  Correspondance.fromVol(Vol vol) : super(
    numero: vol.numero,
    compagnie: vol.compagnie,
    tempsD: vol.tempsD,
    terminalD: vol.terminalD,
    aeroportD: vol.aeroportD,
    tempsA: vol.tempsA,
    terminalA: vol.terminalA,
    aeroportA: vol.aeroportA,
    codeAeroportD: vol.codeAeroportD,
    codeAeroportA: vol.codeAeroportA,
    aeroportDepart: vol.aeroportDepart,
    aeroportArrivee: vol.aeroportArrivee
  ) {
    vols.add(vol);
  }

  Correspondance.fromAutreCorrespondance(Correspondance autreCorrespondance) : super(
    numero: autreCorrespondance.numero,
    compagnie: autreCorrespondance.compagnie,
    tempsD: autreCorrespondance.tempsD,
    terminalD: autreCorrespondance.terminalD,
    aeroportD: autreCorrespondance.aeroportD,
    tempsA: autreCorrespondance.tempsA,
    terminalA: autreCorrespondance.terminalA,
    aeroportA: autreCorrespondance.aeroportA,
    codeAeroportD: autreCorrespondance.codeAeroportD,
    codeAeroportA: autreCorrespondance.codeAeroportA,
    aeroportDepart: autreCorrespondance.aeroportDepart,
    aeroportArrivee: autreCorrespondance.aeroportArrivee
  ) {
    vols.addAll(autreCorrespondance.vols);
  }

  void _ajouterVol(Vol vol) {
    vols.add(vol);
    tempsA = vol.tempsA;
    terminalA = vol.terminalA;
    codeAeroportA = vol.codeAeroportA;
    aeroportA = vol.aeroportA;
    aeroportArrivee = vol.aeroportArrivee;
  }

  bool contientDepart(String texte) {
    return vols.any((vol) => vol.aeroportDepart?.ville.toLowerCase().contains(texte) == true ||
                              vol.aeroportDepart?.pays.toLowerCase().contains(texte) == true);
  }

  bool contientArrivee(String texte) {
    return vols.any((vol) => vol.aeroportArrivee?.ville.toLowerCase().contains(texte) == true ||
                              vol.aeroportArrivee?.pays.toLowerCase().contains(texte) == true);
  }

  static List<Correspondance> _recupererDeparts(List<Vol> vols) {
    final correspondances = <Correspondance>[];

    for (final vol in vols) {
      final aUnVolPrecedent = vols.any((autre) =>
        autre.codeAeroportA == vol.codeAeroportD &&
        autre.tempsA.isBefore(vol.tempsD)
      );

      if (!aUnVolPrecedent) {
        correspondances.add(Correspondance.fromVol(vol));
      }
    }
    return correspondances;
  }

  static void _suiteVolsCorrespondances(Correspondance correspondance, List<Vol> lesVols, List<Correspondance> lesCorrespondances) {
    final volsSuivants = lesVols.where((vol) {return vol.codeAeroportD == correspondance.codeAeroportA && vol.tempsD.isAfter(correspondance.tempsA);}).toList();

    if (volsSuivants.isEmpty) {
      lesCorrespondances.add(correspondance);
    }
    else {
      for (final volSuivant in volsSuivants) {
        final newCorrespondance = Correspondance.fromAutreCorrespondance(correspondance);
        newCorrespondance._ajouterVol(volSuivant);
        _suiteVolsCorrespondances(newCorrespondance, lesVols, lesCorrespondances);
      }
    }
  }

  static List<Correspondance> genererCorrespondances(List<Vol> vols) {
    final correspondances = <Correspondance>[];
    final departs = _recupererDeparts(vols);

    for (final correspondance in departs) {
      _suiteVolsCorrespondances(correspondance, vols, correspondances);
    }

    return correspondances;
  }
}
