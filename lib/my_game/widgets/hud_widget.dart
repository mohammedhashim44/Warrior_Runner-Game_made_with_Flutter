import 'dart:math';
import 'package:flutter/material.dart';

class HudWidget extends StatelessWidget {
  final Function onPauseClicked;
  final ValueNotifier<int> currentPlayerLife;
  final int fullPlayerLife;
  final ValueNotifier<double> attackTimerProgress;

  const HudWidget({
    Key key,
    @required this.onPauseClicked,
    @required this.currentPlayerLife,
    @required this.attackTimerProgress,
    @required this.fullPlayerLife,
  })  : assert(onPauseClicked != null),
        assert(currentPlayerLife != null),
        assert(attackTimerProgress != null),
        assert(fullPlayerLife != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            icon: Icon(
              Icons.pause_circle_filled,
              size: 50,
            ),
            onPressed: () {
              onPauseClicked.call();
            },
          ),
          SizedBox(
            width: 20,
          ),
          ValueListenableBuilder<double>(
            valueListenable: attackTimerProgress,
            builder: (context, double value, child) {
              double progressValue = min(1.0, value);
              if (progressValue == 0.0) progressValue = 1.0;

              bool attackReady = progressValue == 1.0;
              String valueString =
                  (progressValue * 100).toInt().toString().padLeft(2, "0");

              return Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        "$valueString%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              attackReady ? Colors.white : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Attack",
                              style: TextStyle(
                                color:
                                    attackReady ? Colors.black : Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              attackReady ? "Ready" : "Loading",
                              style: TextStyle(
                                color:
                                    attackReady ? Colors.black : Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: currentPlayerLife,
            builder: (context, lifeValue, child) {
              final list = <Widget>[];

              for (int i = 0; i < fullPlayerLife; i++) {
                list.add(
                  Icon(
                    i < lifeValue ? Icons.favorite : Icons.favorite_border,
                    size: 30.0,
                    color: Colors.red,
                  ),
                );
              }
              return Row(
                children: list.reversed.toList(),
              );
            },
            child: null,
          )
        ],
      ),
    );
  }
}
