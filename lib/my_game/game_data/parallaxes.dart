import 'package:flutter/cupertino.dart';
import 'package:flutter_game/my_game/models/parallax_data_model.dart';

enum ParallaxType {
  waterfall,
  nightForest,
  forest,
}

Map<ParallaxType, ParallaxData> parallaxMap = {
  ParallaxType.waterfall: ParallaxData(
    layers: [
      "parallax/parallax_1/sky.png",
      "parallax/parallax_1/clouds_1.png",
      "parallax/parallax_1/clouds_2.png",
      "parallax/parallax_1/rocks.png",
      "parallax/parallax_1/ground.png",
    ],
    groundLayer: "parallax/parallax_1/ground_walk.png",
    displayBackgroundImage:
        "assets/images/parallax/parallax_1/game_background_4.png",
    groundHeight: 194.0,
    baseSpeed: Offset(10, 0),
    layerDelta: Offset(30, 0),
  ),
  ParallaxType.nightForest: ParallaxData(
    layers: [
      "parallax/parallax_2/sky.png",
      "parallax/parallax_2/rocks.png",
      "parallax/parallax_2/clouds_1.png",
      "parallax/parallax_2/clouds_2.png",
      "parallax/parallax_2/ground_1.png",
      "parallax/parallax_2/ground_2.png",
      "parallax/parallax_2/ground_3.png",
      "parallax/parallax_2/plant.png",
    ],
    groundLayer: "parallax/parallax_2/ground_walk.png",
    displayBackgroundImage:
        "assets/images/parallax/parallax_2/game_background_3.1.png",
    groundHeight: 32.0,
    baseSpeed: Offset(20, 0),
    layerDelta: Offset(20, 0),
  ),
  ParallaxType.forest: ParallaxData(
    layers: [
      "parallax/parallax_3/sky.png",
      "parallax/parallax_3/houses3.png",
      "parallax/parallax_3/houses2.png",
      "parallax/parallax_3/houses1.png",
      "parallax/parallax_3/road.png",
      "parallax/parallax_3/crosswalk.png",
    ],
    groundLayer: null,
    groundHeight: 32.0,
    displayBackgroundImage: "assets/images/parallax/parallax_3/City3.png",
    baseSpeed: Offset(20, 0),
    layerDelta: Offset(30, 0),
  ),
};
