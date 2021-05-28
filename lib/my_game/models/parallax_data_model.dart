import 'package:flame/components/parallax_component.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart' as constants;

class ParallaxData {
  final List<String> layers;

  final String groundLayer;
  final double groundHeight;

  final Offset baseSpeed;
  final Offset layerDelta;

  final String displayBackgroundImage;

  ParallaxData({
    @required this.layers,
    @required this.groundHeight,
    @required this.displayBackgroundImage,
    this.groundLayer,
    this.baseSpeed: constants.PARALLAX_BASE_SPEED,
    this.layerDelta: constants.PARALLAX_DELTA_SPEED,
  });

  List<ParallaxImage> getParallaxImages() {
    List<ParallaxImage> images = [];

    layers.forEach((layer) {
      ParallaxImage parallaxImage = ParallaxImage(
        layer,
        fill: LayerFill.height,
      );
      images.add(parallaxImage);
    });

    if (groundLayer != null) {
      ParallaxImage groundImage =
          ParallaxImage(groundLayer, fill: LayerFill.none);
      images.add(groundImage);
    }

    return images;
  }
}
