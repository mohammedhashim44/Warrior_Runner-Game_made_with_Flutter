import 'package:flutter_game/my_game/models/player_data_model.dart';
import 'package:flutter_game/my_game/models/sprite_group.dart';

const int textureWidth = 64;
const int textureHeight = 64;

PlayerData playerData = PlayerData(
  runSpriteGroup: SpriteGroup.fromProvidedList(
    textureHeight: textureHeight,
    textureWidth: textureWidth,
    spritesPaths: [
      "player/Run/Warrior_Run_1.png",
      "player/Run/Warrior_Run_2.png",
      "player/Run/Warrior_Run_3.png",
      "player/Run/Warrior_Run_4.png",
      "player/Run/Warrior_Run_5.png",
      "player/Run/Warrior_Run_6.png",
      "player/Run/Warrior_Run_7.png",
      "player/Run/Warrior_Run_8.png",
    ],
  ),
  hitSpriteGroup: SpriteGroup.fromProvidedList(
    textureHeight: textureHeight,
    textureWidth: textureWidth,
    spritesPaths: [
      "player/Hurt-Effect/Warrior_hurt_1.png",
      "player/Hurt-Effect/Warrior_hurt_2.png",
      "player/Hurt-Effect/Warrior_hurt_3.png",
      "player/Hurt-Effect/Warrior_hurt_4.png",
    ],
  ),
  jumpSpriteGroup: SpriteGroup.fromProvidedList(
    textureHeight: textureHeight,
    textureWidth: textureWidth,
    spritesPaths: [
      "player/Jump/Warrior_Jump_1.png",
      "player/Jump/Warrior_Jump_2.png",
      "player/Jump/Warrior_Jump_3.png",
    ],
  ),
  deathSpriteGroup: SpriteGroup.fromProvidedList(
    textureHeight: textureHeight,
    textureWidth: textureWidth,
    spritesPaths: [
      "player/Death-Effect/Warrior_Death_1.png",
      "player/Death-Effect/Warrior_Death_2.png",
      "player/Death-Effect/Warrior_Death_3.png",
      "player/Death-Effect/Warrior_Death_4.png",
      "player/Death-Effect/Warrior_Death_5.png",
      "player/Death-Effect/Warrior_Death_6.png",
      "player/Death-Effect/Warrior_Death_7.png",
      "player/Death-Effect/Warrior_Death_8.png",
      "player/Death-Effect/Warrior_Death_9.png",
      "player/Death-Effect/Warrior_Death_10.png",
      "player/Death-Effect/Warrior_Death_11.png",
    ],
  ),
  attackSpriteGroup: SpriteGroup.fromProvidedList(
    textureHeight: textureHeight,
    textureWidth: textureWidth,
    spritesPaths: [
      "player/Dash Attack/Warrior_Dash-Attack_4.png",
      "player/Dash Attack/Warrior_Dash-Attack_5.png",
      "player/Dash Attack/Warrior_Dash-Attack_6.png",
      "player/Dash Attack/Warrior_Dash-Attack_7.png",
      "player/Dash Attack/Warrior_Dash-Attack_8.png",
    ],
  ),
);
