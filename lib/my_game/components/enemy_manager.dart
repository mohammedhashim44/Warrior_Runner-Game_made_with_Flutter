import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flutter_game/my_game/game_data/enemies.dart';
import 'package:flutter_game/my_game/my_game.dart';

import 'enemy.dart';
import '../constants.dart' as constants;

class EnemyManager extends Component with HasGameRef<MyGame> {
  Random _random;
  Timer _timer;
  int _spawnLevel;

  EnemyManager() {
    _random = Random();
    _timer = Timer(constants.ENEMY_RESPAWN_RATE_IN_SECONDS,
        repeat: true, callback: spawnEnemy);

    _spawnLevel = 0;
  }

  void spawnEnemy() {
    int enemyTypeIndex = _random.nextInt(EnemyType.values.length);
    EnemyType enemyType = EnemyType.values.elementAt(enemyTypeIndex);
    Enemy enemy = Enemy(enemyType);
    gameRef.addLater(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {
  }

  @override
  void update(double t) {
    _timer.update(t);
    int score = gameRef.score;
    int newSpawnLevel = score ~/ 500;
    if (newSpawnLevel > _spawnLevel) {
      _spawnLevel = newSpawnLevel;
      double newTime =
          (constants.ENEMY_RESPAWN_RATE_IN_SECONDS / (1 + (0.1 * _spawnLevel)));

      _timer.stop();
      _timer = Timer(newTime, repeat: true, callback: spawnEnemy);
      _timer.start();
    }
  }

  void reset(){
    _spawnLevel = 0;
    _timer = Timer(constants.ENEMY_RESPAWN_RATE_IN_SECONDS,
        repeat: true, callback: spawnEnemy);
    _timer.start();
  }
}