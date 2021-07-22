import 'package:flutter/material.dart';

const int TILES_NUMBER_PER_HEIGHT = 4;
const double GRAVITY = -800;
const double JUMP_SPEED_Y = 400;

const Offset PARALLAX_BASE_SPEED = Offset(100, 0);
const Offset PARALLAX_DELTA_SPEED = Offset(50, 0);

const double GROUND_HEIGHT = 32;

const double DEFAULT_RUN_STEP_TIME = 0.05;
const double DEFAULT_DEATH_STEP_TIME = 0.2;

const double DEFAULT_ENEMY_SPEED_X = -250;
const double ENEMY_RESPAWN_RATE_IN_SECONDS = 4;
const double ENEMY_RESPAWN_MINIMUM_TIME = 1.5;

const double PLAYER_ATTACK_LOAD_TIME_IN_SECONDS = 4;
const int PLAYER_LIVES = 10;
const double BULLET_SPEED = 400;
