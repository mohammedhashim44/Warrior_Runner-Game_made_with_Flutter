import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_game/my_game/managers/storage_manager.dart';
import 'game_play.dart';

class PlayGameMenu extends StatefulWidget {
  final Function onSettingsClicked;

  const PlayGameMenu({
    Key key,
    @required this.onSettingsClicked,
  })  : assert(onSettingsClicked != null),
        super(key: key);

  @override
  _PlayGameMenuState createState() => _PlayGameMenuState();
}

class _PlayGameMenuState extends State<PlayGameMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Worrior Runner",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
          Text(
            "Highest Score : ${StorageManager.instance.getHighestScore()}",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Play",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  size: 40,
                )
              ],
            ),
            onPressed: () {
              onPlayClicked.call(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Settings ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.settings,
                  size: 40,
                ),
              ],
            ),
            onPressed: () {
              widget.onSettingsClicked.call();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "How to Play",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "* Left Tap\nJump",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                "* Right Tap\nAttack",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onPlayClicked(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => GamePlay()));
  }
}
