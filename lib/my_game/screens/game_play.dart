import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/my_game.dart';

class GamePlay extends StatelessWidget {
  final MyGame myGame = MyGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myGame.widget,
    );
  }
}
