import 'package:flutter/material.dart';
import '../device_info.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Info')),
      drawer: const MenuDrawer(),
      body: Column(children: [const Text('Phone Info'), DeviceInfo()]),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}
