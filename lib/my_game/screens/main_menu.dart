import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/game_data/parallaxes.dart';
import 'package:flutter_game/my_game/managers/settings_manager.dart';
import 'package:flutter_game/my_game/screens/play_game_menu.dart';
import 'package:flutter_game/my_game/screens/settings.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ValueNotifier<Widget> _selectedWidget;

  @override
  void initState() {
    super.initState();
    _selectedWidget = ValueNotifier(
      PlayGameMenu(
        onSettingsClicked: onSettingsClicked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: SettingsManager.instance.listenableBackgroundIndex,
        builder: (context, int index, Widget child) {
          String backgroundImage =
              parallaxMap.values.elementAt(index).displayBackgroundImage;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 20,
              ),
              child: ValueListenableBuilder<Widget>(
                valueListenable: _selectedWidget,
                builder: (context, Widget myWidget, _) {
                  return AnimatedSwitcher(
                    child: myWidget,
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    switchInCurve: Curves.bounceInOut,
                    switchOutCurve: Curves.easeOutCirc,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSettingsClicked() {
    _selectedWidget.value = Settings(
      onBackClicked: onBackClicked,
    );
  }

  void onBackClicked() {
    _selectedWidget.value = PlayGameMenu(
      onSettingsClicked: onSettingsClicked,
    );
  }
}
