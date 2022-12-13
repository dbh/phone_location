// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';
import 'package:phone_location/shared/device_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  _HomeScreen() {
    print('_HomeScreen constructor');
  }

  storeMqttServer() {
    print('store value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const MenuDrawer(),
      body: Column(
        children: const [
          DeviceInfo(),
        ],
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}
