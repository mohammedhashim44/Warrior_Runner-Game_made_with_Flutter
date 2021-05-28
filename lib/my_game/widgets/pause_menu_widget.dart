import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/screens/main_menu.dart';

class PauseMenuWidget extends StatelessWidget {
  final Function onResumeClicked;

  const PauseMenuWidget({Key key, @required this.onResumeClicked})
      : assert(onResumeClicked != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 100,
      ),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Paused",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    onResumeClicked.call();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resume",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Icon(
                        Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MainMenu()));
                  },
                  child: Text(
                    "Return To Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
