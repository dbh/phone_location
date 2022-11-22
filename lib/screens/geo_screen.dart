import 'package:flutter/material.dart';
import '../geo.dart';
import '../shared/menu_drawer.dart';
import '../shared/bot_nav_bar_custom.dart';

class GeoInfo extends StatelessWidget {
  const GeoInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geo')),
      drawer: MenuDrawer(),
      body: Column(children: [
        Text('Geo'),
        Geo(),
      ]),
      bottomNavigationBar: BotNavBarCustom(),
    );
  }
}
