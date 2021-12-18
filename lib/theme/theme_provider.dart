import 'package:flutter/material.dart';
import '../services/shared_prefs.dart';
import '../theme/constants.dart';

class FlutterFireTheme with ChangeNotifier {
  final _prefs = SharedPrefsService.instance.prefs;
  ThemeMode _currentTheme = ThemeMode.system;

  FlutterFireTheme() {
    final themeFromMemory = _prefs?.getString('theme') ?? 'system';

    switch (themeFromMemory) {
      case 'light':
        _currentTheme = ThemeMode.light;
        break;
      case 'dark':
        _currentTheme = ThemeMode.dark;
        break;
      default:
        _currentTheme = ThemeMode.system;
    }
  }

  get currentTheme => _currentTheme;

  void setCurrentTheme(ThemeMode? mode) {
    _currentTheme = mode ?? ThemeMode.light;

    final _currentThemeString = mode.toString().split('.')[1];
    _prefs!.setString('theme', _currentThemeString);

    notifyListeners();
  }

  final primaryColor = const Color(kPrimaryColor);

  get primarySwatch => const MaterialColor(0xfff95116, kPrimarySwatch);

  getThemeData(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        brightness: brightness,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(primaryColor),
      ),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(selectedItemColor: primaryColor),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: primaryColor,
        ),
      ),
      primarySwatch: primarySwatch,
    );
  }

  get lightTheme => getThemeData(Brightness.light);
  get darkTheme => getThemeData(Brightness.dark);
}
