import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._();
  static SharedPrefsService instance = SharedPrefsService._();

  SharedPreferences? prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
