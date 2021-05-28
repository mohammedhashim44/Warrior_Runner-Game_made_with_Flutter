import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

const HIVE_BOX_NAME = "myGame";

const BGM_KEY = "bgm";
const SFX_KEY = "sfx";
const HIGHEST_SCORE_KEY = "highest_score";
const SELECTED_BACKGROUND_INDEX_KEY = "selected_background_index";

const BOOL_DEFAULT_VALUE = true;

class StorageManager {
  StorageManager._internal();

  static StorageManager _instance = StorageManager._internal();

  static StorageManager get instance => _instance;

  Box box;

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();

    Hive.init(directory.path);
    box = await Hive.openBox(HIVE_BOX_NAME);
  }

  int getSelectedBackgroundIndex() {
    return box.get(SELECTED_BACKGROUND_INDEX_KEY, defaultValue: 0);
  }

  void setSelectedBackgroundIndex(int value) {
    box.put(SELECTED_BACKGROUND_INDEX_KEY, value);
  }

  int getHighestScore() {
    return box.get(HIGHEST_SCORE_KEY, defaultValue: 0);
  }

  void setHighestScore(int score) {
    box.put(HIGHEST_SCORE_KEY, score);
  }

  void setBgmSettings(bool value) {
    box.put(BGM_KEY, value);
  }

  void setSfxSettings(bool value) {
    box.put(SFX_KEY, value);
  }

  bool getBgmSettings() {
    return box.get(BGM_KEY, defaultValue: BOOL_DEFAULT_VALUE);
  }

  bool getSfxSettings() {
    return box.get(SFX_KEY, defaultValue: BOOL_DEFAULT_VALUE);
  }
}
