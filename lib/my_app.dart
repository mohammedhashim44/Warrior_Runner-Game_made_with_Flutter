import 'package:flutter/material.dart';

import 'my_game/screens/main_menu.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Audiowide",
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: "Audiowide"),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(),
    );
  }
}