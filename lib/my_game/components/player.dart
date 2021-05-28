import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_game/my_game/game_data/player_data.dart';
import 'package:flutter_game/my_game/managers/audio_manager.dart';

import '../constants.dart' as constants;

double hitAnimationDuration = 1;

class Player extends AnimationComponent with HasGameRef {
  FlameAnimation.Animation running;
  FlameAnimation.Animation hitting;
  FlameAnimation.Animation jumping;
  FlameAnimation.Animation dying;
  FlameAnimation.Animation attacking;

  double groundLevel;
  double speedY = 0;
  double maxY = 0;

  Timer _hitTimer;
  bool _isHit;
  bool _isAttacking;

  ValueNotifier<int> life;

  Player() : super.empty() {
    loadAnimations();
    this.animation = running;

    life = ValueNotifier(constants.PLAYER_LIVES);
    _isHit = false;
    _isAttacking = false;
    _hitTimer = Timer(hitAnimationDuration, repeat: false, callback: run);

    this.anchor = Anchor.center;
  }

  void loadAnimations() {
    running = FlameAnimation.Animation.spriteList(
      playerData.runSpriteGroup.spriteList,
      stepTime: 0.1,
      loop: true,
    );

    hitting = FlameAnimation.Animation.spriteList(
      playerData.hitSpriteGroup.spriteList,
      stepTime: 0.1,
      loop: true,
    );

    jumping = FlameAnimation.Animation.spriteList(
      playerData.jumpSpriteGroup.spriteList,
      stepTime: 0.1,
      loop: true,
    );

    dying = FlameAnimation.Animation.spriteList(
      playerData.deathSpriteGroup.spriteList,
      stepTime: 0.2,
      loop: false,
    );

    attacking = FlameAnimation.Animation.spriteList(
      playerData.attackSpriteGroup.spriteList,
      stepTime: 0.1,
      loop: false,
    );

    attacking.onCompleteAnimation = onAttackingAnimationFinished;
  }

  void run() {
    _isHit = false;
    this.animation = running;
  }

  void die({Function onDeathAnimationFinished}) {
    dying.onCompleteAnimation = onDeathAnimationFinished;
    this.animation = dying;
  }

  void hit() {
    if (!_isHit) {
      // reset attack , in case player get hit while attacking
      _isAttacking = false;
      this.animation = hitting;
      _isHit = true;
      AudioManager.instance.playDamageSound();
      life.value -= 1;
      _hitTimer.start();
    }
  }

  void attack() {
    if (canLaunchAttack()) {
      this.animation = attacking;
      _isAttacking = true;
      AudioManager.instance.playAttackSound();
    }
  }

  bool canLaunchAttack() {
    return !_isAttacking && !_isHit && isOnGround();
  }

  void onAttackingAnimationFinished() {
    _isAttacking = false;
    attacking.reset();
  }

  @override
  void update(double t) {
    super.update(t);

    speedY = speedY + constants.GRAVITY * t;

    this.y -= speedY * t;

    if (isOnGround()) {
      if (!_hitTimer.isRunning() && !_isAttacking) {
        this.animation = running;
      }
      this.y = groundLevel;
      speedY = 0.0;
    }

    _hitTimer.update(t);
  }

  void jump() {
    if (isOnGround() &&  !_isAttacking) {
      AudioManager.instance.playJumpSound();
      speedY = constants.JUMP_SPEED_Y;
      this.animation = jumping;
    }
  }

  bool isOnGround() {
    return this.y >= groundLevel;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    double tileSize = size.height / constants.TILES_NUMBER_PER_HEIGHT;

    this.width = tileSize;
    this.height = tileSize;

    this.x = tileSize / 2;
    this.y = size.height - this.height / 2 - constants.GROUND_HEIGHT;
    groundLevel = this.y;
  }
}