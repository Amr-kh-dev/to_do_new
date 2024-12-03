import 'package:flutter/material.dart';
import 'package:to_do_new/shared/view/view_model/app_theme.dart';

class SettingProvider with ChangeNotifier {
  ThemeMode? themeMode = ThemeMode.light;
  bool isDarkMode = false;
  bool get isDark => themeMode == ThemeMode.dark;
  Locale _locale = Locale('en');
  bool isDone = false;

  Locale get locale => _locale;

  void changeLocale(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }

  void changeThemeMode() {
    isDarkMode = !isDarkMode;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }
}
