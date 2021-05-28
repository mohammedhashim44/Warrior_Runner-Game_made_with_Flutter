import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flutter_game/my_game/game_data/audio_data.dart';
import 'package:flutter_game/my_game/managers/settings_manager.dart';

class AudioManager {
  Random random;

  AudioManager._internal();

  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init() async {
    Flame.audio.disableLog();
    Flame.audio.clearAll();

    random = Random();
  }

  bool canPlaySfx() {
    return SettingsManager.instance.listenableSfx.value;
  }

  bool canPlayBgm() {
    return SettingsManager.instance.listenableBgm.value;
  }

  void playBgm() {
    if (canPlayBgm()) {
      Flame.bgm.play(
        AudioData.backgroundMusic,
        volume: 0.3,
      );
    }
  }

  void pauseBgm() {
    if (canPlayBgm()) {
      Flame.bgm.pause();
    }
  }

  void stopBgm() {
    if (canPlayBgm()) {
      Flame.bgm.stop();
    }
  }

  void resumeBgm() {
    if (canPlayBgm()) {
      Flame.bgm.resume();
    }
  }

  void playExplosionSound() {
    String file = getRandomElement(AudioData.explosionSounds);
    playSfx(file);
  }

  void playAttackSound() {
    String file = getRandomElement(AudioData.attackSounds);
    playSfx(file);
  }

  void playJumpSound() {
    String file = getRandomElement(AudioData.jumpSounds);
    playSfx(file);
  }

  void playDamageSound() {
    String file = getRandomElement(AudioData.damageSounds);
    playSfx(file);
  }

  void playSfx(String fileName) {
    if (canPlaySfx()) {
      Flame.audio.play(fileName);
    }
  }

  String getRandomElement(List<String> list) {
    int index = random.nextInt(list.length);
    return list[index];
  }
}
