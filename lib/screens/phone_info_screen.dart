import 'package:flutter/material.dart';
import '../device_info.dart';
import '../shared/menu_drawer.dart';
import '../shared/bot_nav_bar_custom.dart';

class PhoneInfo extends StatelessWidget {
  const PhoneInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Info')),
      drawer: MenuDrawer(),
      body: Column(children: [Text('Phone Info'), DeviceInfo()]),
      bottomNavigationBar: BotNavBarCustom(),
    );
  }
}
