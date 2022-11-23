import 'package:flutter/material.dart';
import '../geo.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class GeoScreen extends StatelessWidget {
  const GeoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geo')),
      drawer: MenuDrawer(),
      body: Column(children: [
        Geo(),
      ]),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}
