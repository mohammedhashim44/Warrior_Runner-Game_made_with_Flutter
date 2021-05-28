import 'package:flutter/cupertino.dart';
import 'package:flutter_game/my_game/managers/storage_manager.dart';

class SettingsManager {
  SettingsManager._internal();

  static SettingsManager _instance = SettingsManager._internal();

  static SettingsManager get instance => _instance;

  ValueNotifier<bool> _bgmNotifier;
  ValueNotifier<bool> _sfxNotifier;
  ValueNotifier<int> _backgroundIndexNotifier;

  ValueNotifier<bool> get listenableBgm => _bgmNotifier;
  ValueNotifier<bool> get listenableSfx => _sfxNotifier;
  ValueNotifier<int> get listenableBackgroundIndex => _backgroundIndexNotifier;

  Future<void> init() async {
    bool bgmValue = StorageManager.instance.getBgmSettings();
    bool sfxValue = StorageManager.instance.getSfxSettings();
    int backgroundIndex = StorageManager.instance.getSelectedBackgroundIndex();

    _bgmNotifier = ValueNotifier(bgmValue);
    _sfxNotifier = ValueNotifier(sfxValue);
    _backgroundIndexNotifier = ValueNotifier(backgroundIndex);
  }

  void setBgm(bool value) {
    _bgmNotifier.value = value;
    StorageManager.instance.setBgmSettings(value);
  }

  void setSfx(bool value) {
    _sfxNotifier.value = value;
    StorageManager.instance.setSfxSettings(value);
  }

  void setBackgroundIndex(int value){
    _backgroundIndexNotifier.value = value ;
    StorageManager.instance.setSelectedBackgroundIndex(value);
  }

}
