import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/preferences.dart';
import '../screens/geo_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Geo Info',
      'Prefs',
    ];

    List<Widget> menuItems = [];

    // ignore: prefer_const_constructors
    menuItems.add(DrawerHeader(
        decoration: const BoxDecoration(color: Colors.blue),
        child: const Text('Locative Phone',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ))));
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(
          element,
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = const HomeScreen();
              break;
            case 'Geo Info':
              screen = const GeoScreen();
              break;
            case 'Prefs':
              screen = const PreferencesScreen();
              break;
            default:
          }
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    });
    return menuItems;
  }
}
