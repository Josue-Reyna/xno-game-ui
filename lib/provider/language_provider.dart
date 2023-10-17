import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  bool language = true;
  String get whatLanguage => language ? 'es' : 'en';

  void changeLanguage() {
    language = !language;
    notifyListeners();
  }
}
