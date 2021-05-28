import 'package:flame/anchor.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flame/gestures.dart';
import 'package:flutter_game/my_game/game_data/parallaxes.dart';
import 'package:flutter_game/my_game/managers/audio_manager.dart';
import 'package:flutter_game/my_game/components/bullet.dart';
import 'package:flutter_game/my_game/components/enemy.dart';
import 'package:flutter_game/my_game/components/enemy_manager.dart';
import 'package:flutter_game/my_game/components/explosion.dart';
import 'package:flutter_game/my_game/managers/settings_manager.dart';
import 'package:flutter_game/my_game/managers/storage_manager.dart';
import 'package:flutter_game/my_game/widgets/game_over_widget.dart';
import 'package:flutter_game/my_game/widgets/hud_widget.dart';
import 'package:flutter_game/my_game/widgets/pause_menu_widget.dart';
import 'constants.dart' as constants;
import 'components/player.dart';

class MyGame extends BaseGame with TapDetector, HasWidgetsOverlay {
  EnemyManager _enemyManager;
  Player _player;
  ParallaxComponent _background;

  TextComponent _scoreComponent;
  int score;
  double _elapsedTime = 0.0;

  bool _isGameOver = false;
  bool _isGamePaused = false;

  Timer _bulletLoadingTimer;
  ValueNotifier<double> _bulletLoadingProgressNotifier;
  bool _bulletIsLoaded;

  MyGame() {
    initGame();
  }

  void initGame() {
    // start background music
    AudioManager.instance.playBgm();

    // Get background index from settings
    int selectedBackgroundIndex =
        SettingsManager.instance.listenableBackgroundIndex.value;
    var parallaxData = parallaxMap.values.elementAt(selectedBackgroundIndex);

    _background = ParallaxComponent(
      parallaxData.getParallaxImages(),
      baseSpeed: parallaxData.baseSpeed,
      layerDelta: parallaxData.layerDelta,
    );
    add(_background);

    _player = Player();
    _player.run();
    add(_player);

    _enemyManager = EnemyManager();
    add(_enemyManager);

    _bulletIsLoaded = true;
    _bulletLoadingProgressNotifier = ValueNotifier(1.0);
    _bulletLoadingTimer = Timer(
      constants.PLAYER_ATTACK_LOAD_TIME_IN_SECONDS,
      repeat: false,
      callback: onAttackTimerFinished,
    );

    score = 0;
    _scoreComponent = TextComponent(score.toString());
    _scoreComponent.config = TextConfig(
      color: Colors.white,
      fontSize: 25,
      fontFamily: "Audiowide",
    );
    _scoreComponent.anchor = Anchor.center;
    add(_scoreComponent);

    // Widget for attack loading, life, and pause button
    addWidgetOverlay(
      "hud",
      HudWidget(
        onPauseClicked: pauseGame,
        currentPlayerLife: _player.life,
        attackTimerProgress: _bulletLoadingProgressNotifier,
        fullPlayerLife: constants.PLAYER_LIVES,
      ),
    );
  }

  void checkPlayerCollision() {
    // Only check the enemies that are alive
    components
        .whereType<Enemy>()
        .where((enemy) => !enemy.isDead())
        .forEach((enemy) {
      Offset playerPosition = _player.toRect().center;
      Offset enemyPosition = enemy.toRect().center;

      var distance = (playerPosition - enemyPosition).distance.abs();

      if (distance <= 30) {
        _player.hit();
      }
    });
  }

  void checkBulletsCollision() {
    List<Bullet> bullets = this.components.whereType<Bullet>().toList();

    // only check alive enemies
    List<Enemy> enemies = this
        .components
        .whereType<Enemy>()
        .where((enemy) => !enemy.isDead())
        .toList();

    for (final enemy in enemies) {
      bool enemyKilled = false;
      if (enemyKilled) {
        continue;
      }

      for (final bullet in bullets) {
        var distance =
            (enemy.toRect().center.distance - bullet.toRect().center.distance)
                .abs();
        if (distance < 20) {
          enemy.die();
          this.markToRemove(bullet);

          AudioManager.instance.playExplosionSound();
          Explosion explosion = Explosion(enemy.toRect().center.dx,
              enemy.toRect().center.dy, enemy.screenSize);

          addLater(explosion);
          enemyKilled = true;

          break;
        }
      }
    }
  }

  void onAttackTimerFinished() {
    _bulletIsLoaded = true;
  }

  void launchAttack() {
    if (_bulletIsLoaded && _player.canLaunchAttack()) {
      _player.attack();
      _bulletIsLoaded = false;
      _bulletLoadingTimer.start();
      Bullet bullet = Bullet(_player.x, _player.y);
      addLater(bullet);
    }
  }

  void pauseGame() {
    _isGamePaused = true;
    pauseEngine();
    AudioManager.instance.pauseBgm();

    if (!_isGameOver) {
      addWidgetOverlay(
        "pauseMenu",
        PauseMenuWidget(
          onResumeClicked: resumeGame,
        ),
      );
    }
  }

  void resumeGame() {
    _isGamePaused = false;
    removeWidgetOverlay("pauseMenu");
    resumeEngine();
    AudioManager.instance.resumeBgm();
  }

  void gameOver() {
    _isGameOver = true;
    pauseEngine();
    AudioManager.instance.stopBgm();

    bool newHighestScore = false;
    int highestScore = StorageManager.instance.getHighestScore();
    if (score > highestScore) {
      StorageManager.instance.setHighestScore(score);
      newHighestScore = true;
    }

    addWidgetOverlay(
      "gameOver",
      GameOverWidget(
        score: score,
        onRestartGameClicked: restartGame,
        newHighestScore: newHighestScore,
      ),
    );
  }

  void resetGame() {
    score = 0;
    _player.life.value = constants.PLAYER_LIVES;
    _player.run();

    _enemyManager.reset();
    // Remove all enemies
    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });
  }

  void restartGame() {
    _isGameOver = false;
    resetGame();
    removeWidgetOverlay("gameOver");
    resumeGame();
  }

  @override
  void update(double t) {
    super.update(t);

    _elapsedTime += t;
    if (_elapsedTime > (1 / 60)) {
      _elapsedTime = 0.0;
      score += 1;
      _scoreComponent.text = score.toString();
    }

    checkPlayerCollision();

    checkBulletsCollision();

    // Game over only when player animation if finished
    if (_player.life.value <= 0) {
      _player.die(onDeathAnimationFinished: gameOver);
    }

    _bulletLoadingTimer.update(t);
    _bulletLoadingProgressNotifier.value = _bulletLoadingTimer.progress;
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _scoreComponent.setByPosition(
      Position((size.width / 2), (_scoreComponent.height)),
    );
    _player.resize(size);
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    if (!_isGameOver && !_isGamePaused) {
      // Check if the click on right or left side
      var width = details.globalPosition.dx;
      if (width < size.width / 2) {
        _player.jump();
      } else {
        launchAttack();
      }
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    if (state != AppLifecycleState.resumed) {
      pauseGame();
    }
  }

  @override
  void onDetach() {
    AudioManager.instance.stopBgm();
    super.onDetach();
  }
}
