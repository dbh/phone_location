import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/phone_info_screen.dart';
import '../screens/geo_screen.dart';
import '../screens/preferences.dart';

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
    final List<String> menuTitles = ['Home', 'Phone Info', 'Geo Info', 'Prefs'];

    List<Widget> menuItems = [];

    menuItems.add(DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
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
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = HomeScreen();
              break;
            case 'Phone Info':
              screen = PhoneScreen();
              break;
            case 'Geo Info':
              screen = GeoScreen();
              break;
            case 'Prefs':
              screen = PreferencesScreen();
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
