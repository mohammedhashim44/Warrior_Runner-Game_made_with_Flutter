import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/my_game/game_data/bullet_data.dart';

import '../constants.dart' as constants;

class Explosion extends AnimationComponent {
  double _speed = 0;

  double _textureWidth = 46;
  double _textureHeight = 46;

  Explosion(double x, double y, Size size) : super.empty() {
    double _scale = (size.height / constants.TILES_NUMBER_PER_HEIGHT) /
        (_textureHeight * 1);

    this.height = _textureHeight.toDouble() * _scale;
    this.width = _textureWidth.toDouble() * _scale;

    this.x = x;
    this.y = y;

    SpriteSheet spriteSheet = SpriteSheet(
      imageName: BulletData.explosion,
      textureWidth: 46,
      textureHeight: 46,
      columns: 7,
      rows: 1,
    );

    this.animation = spriteSheet.createAnimation(
      0,
      from: 0,
      to: 6,
      loop: false,
      stepTime: 0.2,
    );

    this.anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x = this.x + dt * _speed;
  }

  @override
  bool destroy() {
    return this.animation.done();
  }
}
