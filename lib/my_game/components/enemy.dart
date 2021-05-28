import 'dart:ui';

import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flutter_game/my_game/game_data/enemies.dart';
import 'package:flutter_game/my_game/models/enemy_data_model.dart';

import '../constants.dart' as constants;

class Enemy extends AnimationComponent {
  double _scale;

  final EnemyType _enemyType;
  EnemyData _enemyData;

  FlameAnimation.Animation _runAnimation;
  FlameAnimation.Animation _deathAnimation;

  Size screenSize;

  Enemy(this._enemyType) : super.empty() {
    _enemyData = enemyMap[_enemyType];

    _runAnimation = FlameAnimation.Animation.spriteList(
      _enemyData.runSpriteGroup.spriteList,
      stepTime: _enemyData.runStepTime,
      loop: true,
    );

    _deathAnimation = FlameAnimation.Animation.spriteList(
      _enemyData.deathSpriteGroup.spriteList,
      stepTime: _enemyData.deathStepTime,
      loop: false,
    );

    this.animation = _runAnimation;
    this.renderFlipX = _enemyData.flipX;
  }

  @override
  void update(double t) {
    super.update(t);
    var movementSpeed = _enemyData.speed;
    if (isDead()) {
      movementSpeed = movementSpeed / 3;
    }
    this.x = this.x + movementSpeed * t;
  }

  @override
  bool destroy() {
    if (this.animation == _deathAnimation && this.animation.done()) return true;

    return (this.x < (-this.width));
  }

  void die() {
    this.animation = _deathAnimation;

    this.height = _enemyData.deathSpriteGroup.textureHeight.toDouble() *
        _scale *
        _enemyData.customScale;
    this.width = _enemyData.deathSpriteGroup.textureWidth.toDouble() *
        _scale *
        _enemyData.customScale;

  }

  bool isDead() {
    return this.animation == _deathAnimation;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    screenSize = size;
    double tileSize = size.height / constants.TILES_NUMBER_PER_HEIGHT;

    _scale = tileSize / (_enemyData.runSpriteGroup.textureHeight * 1);

    this.height = _enemyData.runSpriteGroup.textureHeight.toDouble() *
        _scale *
        _enemyData.customScale;
    this.width = _enemyData.runSpriteGroup.textureWidth.toDouble() *
        _scale *
        _enemyData.customScale;

    this.x = size.width;
    this.y = size.height -
        this.height -
        constants.GROUND_HEIGHT +
        _enemyData.fromGroundOffset;
  }
}
