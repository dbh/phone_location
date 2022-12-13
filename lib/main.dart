import 'package:flutter/material.dart';
import 'package:phone_location/screens/geo_screen.dart';
import 'package:phone_location/screens/preferences.dart';
import 'package:phone_location/shared/user_phone_data.dart';
import 'package:phone_location/shared/user_shared_prefs.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPrefs.init();
  await UserPhoneData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/': (context) => const HomeScreen(),
        'geo': (context) => const GeoScreen(),
        'prefs': (context) => const PreferencesScreen()
      },
      initialRoute: '/',
    );
  }
}
