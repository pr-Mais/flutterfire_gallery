import 'package:flutter/material.dart';
import 'package:flutterfire_gallery/theme/constants.dart';

class FlutterFireTheme {
  get currentTheme => _currentTheme;
  ThemeMode _currentTheme = ThemeMode.light;

  void setCurrentTheme(ThemeMode? mode) {
    _currentTheme = mode ?? ThemeMode.light;
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
