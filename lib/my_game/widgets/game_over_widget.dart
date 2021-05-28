import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/screens/main_menu.dart';

class GameOverWidget extends StatelessWidget {
  final int score;
  final Function onRestartGameClicked;
  final bool newHighestScore;

  const GameOverWidget({
    Key key,
    @required this.score,
    @required this.onRestartGameClicked,
    this.newHighestScore = false,
  })  : assert(score != null),
        assert(onRestartGameClicked != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 50,
      ),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            20,
          )),
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Game Over",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                if (newHighestScore)
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Text(
                      "New Highest Score",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                Text(
                  "Your score was $score",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    onRestartGameClicked.call();
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Play Again",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.replay,
                            size: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    goToMainMenu(context);
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Go to Menu",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.menu,
                            size: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),
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

  void goToMainMenu(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MainMenu()));
  }
}