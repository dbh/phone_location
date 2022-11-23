import 'package:flutter/material.dart';
import 'package:phone_location/screens/geo_screen.dart';
import 'package:phone_location/screens/phone_info_screen.dart';
import 'package:phone_location/screens/preferences.dart';
import 'geo.dart';
import 'device_info.dart';
import 'screens/home_screen.dart';
import './shared/menu_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locative Phone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      routes: {
        '/': (context) => HomeScreen(),
        'phone': (context) => PhoneScreen(),
        'geo': (context) => GeoScreen(),
        'prefs': (context) => PreferencesScreen()
      },
      initialRoute: '/',
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   String title = 'whatever';
//   MyHomePage(String title) {
//     this.title = title;
//   }

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       bottomNavigationBar: BottomNavigationBar(items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.phone_iphone),
//           label: 'Phone',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.map),
//           label: 'Location',
//         ),
//       ]),
//       drawer: MenuDrawer(),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[Text('Home')],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
