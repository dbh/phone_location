import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();
}
