import 'package:flutter/material.dart';
import 'geo.dart';
import 'device_info.dart';

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
      home: MyHomePage('Locative Phone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title = 'whatever';
  MyHomePage(String title) {
    this.title = title;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   'Times: ',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.displaySmall,
            // ),
            DeviceInfo(),
            Geo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
