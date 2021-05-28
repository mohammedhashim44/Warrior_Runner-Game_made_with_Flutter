import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/my_game/game_data/enemies.dart';
import 'package:flutter_game/my_game/game_data/parallaxes.dart';
import 'package:flutter_game/my_game/game_data/player_data.dart';
import 'package:flutter_game/my_game/managers/audio_manager.dart';
import 'package:flutter_game/my_game/managers/settings_manager.dart';
import 'package:flutter_game/my_game/managers/storage_manager.dart';
import 'my_app.dart';
import 'my_game/game_data/audio_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  // Hide Status bar
  await SystemChrome.setEnabledSystemUIOverlays([]);

  await loadGameImages();
  await loadAudioFiles();

  await StorageManager.instance.init();
  await SettingsManager.instance.init();
  await AudioManager.instance.init();

  runApp(MyApp());
}

Future<void> loadGameImages() async {
  List<String> allImages = [];

  // loop through player and enemies and load files
  allImages
    ..addAll(playerData.runSpriteGroup.spritePaths)
    ..addAll(playerData.jumpSpriteGroup.spritePaths)
    ..addAll(playerData.attackSpriteGroup.spritePaths)
    ..addAll(playerData.deathSpriteGroup.spritePaths)
    ..addAll(playerData.hitSpriteGroup.spritePaths);

  enemyMap.values.forEach((enemyData) {
    List<String> enemyAssets = [];

    if (enemyData.runSpriteGroup.spriteSheetPath != null) {
      enemyAssets.add(enemyData.runSpriteGroup.spriteSheetPath);
    } else {
      enemyAssets.addAll(enemyData.runSpriteGroup.spritePaths);
    }

    if (enemyData.deathSpriteGroup.spriteSheetPath != null) {
      enemyAssets.add(enemyData.deathSpriteGroup.spriteSheetPath);
    } else {
      enemyAssets.addAll(enemyData.deathSpriteGroup.spritePaths);
    }

    allImages.addAll(enemyAssets);
  });

  // loop through parallax images and add them
  parallaxMap.values.forEach((parallax) {
    List<String> images = List<String>.from(parallax.layers).toList();
    if (parallax.groundLayer != null) {
      images.add(parallax.groundLayer);
    }

    allImages.addAll(images);
  });

  await Flame.images.loadAll(allImages);
}

Future<void> loadAudioFiles() async {
  List<String> allAudioFiles = [];
  allAudioFiles
    ..add(AudioData.backgroundMusic)
    ..addAll(AudioData.attackSounds)
    ..addAll(AudioData.damageSounds)
    ..addAll(AudioData.jumpSounds);

  await Flame.audio.loadAll(allAudioFiles);
}
