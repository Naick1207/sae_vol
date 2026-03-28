import 'package:flutter/foundation.dart';
import 'dart:io';

class Config {
  static String get apiUrl {
    if (kIsWeb) {
      return 'http://localhost:5000';
    }
    else {
      return 'http://10.0.2.2:5000'; // Remplacez par l'adresse IP du PC avec l'API dans le cas où vous le lancez sur appareil Android
    }
  }
}