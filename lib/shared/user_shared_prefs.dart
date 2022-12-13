import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();
  static const _mqttServer = 'mqtt_server';
  static const _mqttUser = 'mqtt_user';
  static const _mqttPassword = 'mqtt_password';

  static Future setMqttServer(String mqttServer) async {
    await _prefs.setString(_mqttServer, mqttServer);
  }

  static String? getMqttServer() => _prefs.getString(_mqttServer);

  static Future setMqttUser(String user) async {
    await _prefs.setString(_mqttUser, user);
  }

  static String? getMqttUser() => _prefs.getString(_mqttUser);

  static Future setMqttPassword(String password) async {
    await _prefs.setString(_mqttPassword, password);
  }

  static String? getMqttPassword() => _prefs.getString(_mqttPassword);
}
