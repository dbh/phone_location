import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();
  static const _mqtt_server = 'mqtt_server';
  static const _mqtt_user = 'mqtt_user';
  static const _mqtt_password = 'mqtt_password';

  static Future setMqttServer(String mqttServer) async {
    await _prefs.setString(_mqtt_server, mqttServer);
  }

  static String? getMqttServer() => _prefs.getString(_mqtt_server);

  static Future setMqttUser(String user) async {
    await _prefs.setString(_mqtt_user, user);
  }

  static String? getMqttUser() => _prefs.getString(_mqtt_user);

  static Future setMqttPassword(String password) async {
    await _prefs.setString(_mqtt_password, password);
  }

  static String? getMqttPassword() => _prefs.getString(_mqtt_password);
}
