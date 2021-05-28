import 'package:flutter_game/my_game/models/enemy_data_model.dart';
import 'package:flutter_game/my_game/models/sprite_group.dart';

import '../constants.dart' as constants;

enum EnemyType {
  Knight,
  Adventurer,
  Gino,
  Skeleton,
  Bat,
}

Map<EnemyType, EnemyData> enemyMap = {
  EnemyType.Bat: EnemyData(
    runSpriteGroup: SpriteGroup.fromSpriteSheet(
      path: "enemies/bat/Flying (46x30).png",
      rows: 1,
      cols: 7,
      textureHeight: 30,
      textureWidth: 46,
    ),
    deathSpriteGroup: SpriteGroup.fromSpriteSheet(
      path: "enemies/bat/Hit (46x30).png",
      rows: 1,
      cols: 5,
      textureHeight: 30,
      textureWidth: 46,
    ),
    speed: constants.DEFAULT_ENEMY_SPEED_X,
    flipX: false,
    customScale: 0.5,
  ),
  EnemyType.Skeleton: EnemyData(
    runSpriteGroup: SpriteGroup.fromSpriteSheet(
      path: "enemies/skeleton/walk.png",
      rows: 1,
      cols: 13,
      textureHeight: 33,
      textureWidth: 22,
    ),
    deathSpriteGroup: SpriteGroup.fromSpriteSheet(
      path: "enemies/skeleton/dead.png",
      rows: 1,
      cols: 13,
      textureHeight: 32,
      textureWidth: 33,
    ),
    speed: constants.DEFAULT_ENEMY_SPEED_X,
    customScale: 0.8,
    deathStepTime: 0.1,
  ),
  EnemyType.Knight: EnemyData(
    runSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/knight/run/HeroKnight_Run_0.png",
        "enemies/knight/run/HeroKnight_Run_1.png",
        "enemies/knight/run/HeroKnight_Run_2.png",
        "enemies/knight/run/HeroKnight_Run_3.png",
        "enemies/knight/run/HeroKnight_Run_4.png",
        "enemies/knight/run/HeroKnight_Run_5.png",
        "enemies/knight/run/HeroKnight_Run_6.png",
        "enemies/knight/run/HeroKnight_Run_7.png",
        "enemies/knight/run/HeroKnight_Run_8.png",
        "enemies/knight/run/HeroKnight_Run_9.png",
      ],
      textureWidth: 100,
      textureHeight: 55,
    ),
    deathSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/knight/death/HeroKnight_Death_0.png",
        "enemies/knight/death/HeroKnight_Death_1.png",
        "enemies/knight/death/HeroKnight_Death_2.png",
        "enemies/knight/death/HeroKnight_Death_3.png",
        "enemies/knight/death/HeroKnight_Death_4.png",
        "enemies/knight/death/HeroKnight_Death_5.png",
        "enemies/knight/death/HeroKnight_Death_6.png",
        "enemies/knight/death/HeroKnight_Death_7.png",
        "enemies/knight/death/HeroKnight_Death_8.png",
        "enemies/knight/death/HeroKnight_Death_9.png",
      ],
      textureWidth: 100,
      textureHeight: 55,
    ),
    speed: constants.DEFAULT_ENEMY_SPEED_X,
    fromGroundOffset: 5,
  ),
  EnemyType.Adventurer: EnemyData(
    runSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/adventurer/run/adventurer-run-00.png",
        "enemies/adventurer/run/adventurer-run-01.png",
        "enemies/adventurer/run/adventurer-run-02.png",
        "enemies/adventurer/run/adventurer-run-03.png",
        "enemies/adventurer/run/adventurer-run-04.png",
        "enemies/adventurer/run/adventurer-run-05.png",
      ],
      textureWidth: 50,
      textureHeight: 37,
    ),
    deathSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/adventurer/death/adventurer-die-00.png",
        "enemies/adventurer/death/adventurer-die-01.png",
        "enemies/adventurer/death/adventurer-die-02.png",
        "enemies/adventurer/death/adventurer-die-03.png",
        "enemies/adventurer/death/adventurer-die-04.png",
        "enemies/adventurer/death/adventurer-die-05.png",
        "enemies/adventurer/death/adventurer-die-06.png",
      ],
      textureWidth: 50,
      textureHeight: 37,
    ),
    speed: constants.DEFAULT_ENEMY_SPEED_X,
    runStepTime: 0.2,
    fromGroundOffset: 5,
  ),
  EnemyType.Gino: EnemyData(
    runSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/gino/run/run01.png",
        "enemies/gino/run/run02.png",
        "enemies/gino/run/run03.png",
        "enemies/gino/run/run04.png",
        "enemies/gino/run/run05.png",
        "enemies/gino/run/run06.png",
        "enemies/gino/run/run07.png",
        "enemies/gino/run/run08.png",
      ],
      textureWidth: 64,
      textureHeight: 64,
    ),
    deathSpriteGroup: SpriteGroup.fromProvidedList(
      spritesPaths: [
        "enemies/gino/death/death01.png",
        "enemies/gino/death/death02.png",
        "enemies/gino/death/death03.png",
        "enemies/gino/death/death04.png",
        "enemies/gino/death/death05.png",
      ],
      textureWidth: 64,
      textureHeight: 64,
    ),
    speed: constants.DEFAULT_ENEMY_SPEED_X,
    fromGroundOffset: 5,
  ),
};
