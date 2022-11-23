// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:phone_location/shared/user_shared_prefs.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  State<PreferencesScreen> createState() => _PreferencesScreen();
}

class _PreferencesScreen extends State<PreferencesScreen> {
  String mqttServer = '';
  String mqttUser = '';
  String mqttPassword = '';

  _PreferencesScreen() {
    mqttServer = UserSharedPrefs.getMqttServer() ?? '';
    mqttUser = UserSharedPrefs.getMqttUser() ?? '';
    mqttPassword = UserSharedPrefs.getMqttPassword() ?? '';
  }

  saveIt() async {
    await UserSharedPrefs.setMqttServer(mqttServer);
    await UserSharedPrefs.setMqttUser(mqttUser);
    await UserSharedPrefs.setMqttPassword(mqttPassword);
  }

  Widget buildSaveButton() => ElevatedButton(
        onPressed: () async => saveIt(),
        child: const Text('Save'),
      );

  @override
  void initState() {
    mqttServer = UserSharedPrefs.getMqttServer() ?? '';
    mqttUser = UserSharedPrefs.getMqttUser() ?? '';
    mqttPassword = UserSharedPrefs.getMqttPassword() ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prefs')),
      drawer: MenuDrawer(),
      body: Column(
        children: [
          Text('Prefs'),
          TextFormField(
            initialValue: mqttServer,
            decoration: InputDecoration(labelText: 'MQTT Server'),
            onChanged: (value) => setState(() {
              mqttServer = value;
            }),
          ),
          TextFormField(
            initialValue: mqttUser,
            decoration: InputDecoration(labelText: 'MQTT User'),
            onChanged: (value) => setState(() {
              mqttUser = value;
            }),
          ),
          TextFormField(
            initialValue: mqttPassword,
            obscureText: true,
            decoration: InputDecoration(labelText: 'MQTT Password'),
            onChanged: (value) => setState(() {
              mqttPassword = value;
            }),
          ),
          buildSaveButton(),
        ],
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}
