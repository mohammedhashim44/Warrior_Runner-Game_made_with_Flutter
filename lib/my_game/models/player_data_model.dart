import 'package:flutter_game/my_game/models/sprite_group.dart';

class PlayerData {
  final SpriteGroup runSpriteGroup;
  final SpriteGroup deathSpriteGroup;
  final SpriteGroup hitSpriteGroup;
  final SpriteGroup jumpSpriteGroup;
  final SpriteGroup attackSpriteGroup;

  PlayerData(
      {this.runSpriteGroup,
      this.deathSpriteGroup,
      this.hitSpriteGroup,
      this.jumpSpriteGroup,
      this.attackSpriteGroup});
}
