import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.phone_iphone),
          label: 'Phone',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Location',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, 'phone');
            break;
          case 2:
            Navigator.pushNamed(context, 'geo');
            break;
        }
      },
    );
  }
}
