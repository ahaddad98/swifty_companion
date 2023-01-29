import 'package:flutter/material.dart';
import 'package:swiftycompanion/prefences.dart';

class DarkModeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  bool switchMode() {
    _isDark = !_isDark;
    MyPreferences.storeDarkMode(isDarkMode: isDark);
    notifyListeners();
    return _isDark;
  }

  void setMode(bool isDark) {
    _isDark = isDark;
    MyPreferences.storeDarkMode(isDarkMode: isDark);
    notifyListeners();
  }
}
