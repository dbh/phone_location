// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';
import '../shared/bot_nav_bar_custom.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intro')),
      drawer: MenuDrawer(),
      body: Center(child: Text('Intro')),
      bottomNavigationBar: BotNavBarCustom(),
    );
  }
}
