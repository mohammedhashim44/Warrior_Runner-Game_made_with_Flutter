import 'package:flutter_game/my_game/models/sprite_group.dart';

import '../constants.dart' as constants ;

class EnemyData {
  final SpriteGroup runSpriteGroup;
  final SpriteGroup deathSpriteGroup;

  final bool flipX;

  final double runStepTime;
  final double deathStepTime;

  final double speed;
  final double customScale ;

  // Use this if the sprite you are using have some padding on the bottom
  // for example if your enemy sprite has 10px padding from bottom
  // it will be appear 10px on top of the ground
  // by using this, the Y of the sprite will be pulled down by this number
  final double fromGroundOffset;

  EnemyData({
    this.runSpriteGroup,
    this.deathSpriteGroup,
    this.flipX : true,
    this.runStepTime : constants.DEFAULT_RUN_STEP_TIME,
    this.deathStepTime : constants.DEFAULT_DEATH_STEP_TIME,
    this.speed : constants.DEFAULT_ENEMY_SPEED_X,
    this.customScale : 1,
    this.fromGroundOffset = 0 ,
  });
}
