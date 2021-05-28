import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/game_data/bullet_data.dart';
import '../constants.dart' as constants;

class Bullet extends AnimationComponent {
  double _width = 50;

  double _height = 50;

  Size _size;

  Bullet(double x, double y) : super.empty() {
    this.x = x;
    this.y = y;
    this.width = _width;
    this.height = _height;

    SpriteSheet spriteSheet = SpriteSheet(
      imageName: BulletData.movingBullet,
      textureWidth: 46,
      textureHeight: 46,
      columns: 6,
      rows: 1,
    );

    this.animation = spriteSheet.createAnimation(
      0,
      from: 0,
      to: 5,
      stepTime: 0.1,
      loop: true
    );


  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x = this.x + dt * constants.BULLET_SPEED;
  }

  @override
  bool destroy() {
    return (this.x > (_size.width + this.width));
  }


  @override
  void resize(Size size) {
    _size = size;
  }

}
