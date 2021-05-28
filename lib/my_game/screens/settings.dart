import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/game_data/parallaxes.dart';
import 'package:flutter_game/my_game/managers/settings_manager.dart';

class Settings extends StatefulWidget {
  final Function onBackClicked;

  const Settings({
    Key key,
    @required this.onBackClicked,
  })  : assert(onBackClicked != null),
        super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: widget.onBackClicked,
                ),
              ),
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Expanded(child: Container())
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: SettingsManager.instance.listenableBgm,
            builder: (context, bool bgm, _) {
              return SwitchListTile(
                title: Text(
                  "Background Music",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                value: bgm,
                onChanged: (bool value) {
                  SettingsManager.instance.setBgm(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: SettingsManager.instance.listenableSfx,
            builder: (context, bool sfx, _) {
              return SwitchListTile(
                title: Text(
                  "Sound Effects",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                value: sfx,
                onChanged: (bool value) {
                  SettingsManager.instance.setSfx(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: SettingsManager.instance.listenableBackgroundIndex,
            builder: (context, int selectedIndex, _) {
              var backgroundImages = parallaxMap.values.toList();

              return Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: backgroundImages.map((e) {
                    int index = backgroundImages.indexOf(e);
                    bool backgroundSelected = index == selectedIndex;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!backgroundSelected) {
                            SettingsManager.instance.setBackgroundIndex(index);
                            SettingsManager.instance.listenableBackgroundIndex
                                .value = index;
                          }
                        },
                        child: BackgroundImageWidget(
                          e.displayBackgroundImage,
                          isSelected: backgroundSelected,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final String image;
  final bool isSelected;

  const BackgroundImageWidget(this.image, {this.isSelected: false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
        border: !isSelected
            ? null
            : Border.all(
                color: Colors.yellow,
                width: 2,
              ),
        color: Colors.transparent,
      ),
    );
  }
}
