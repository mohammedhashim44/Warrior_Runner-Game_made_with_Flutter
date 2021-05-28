import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';

class SpriteGroup {
  List<Sprite> spriteList;
  int textureHeight;
  int textureWidth;

  List<String> spritePaths;
  String spriteSheetPath;

  SpriteGroup({this.spriteList, this.textureHeight, this.textureWidth});

  SpriteGroup.fromSpriteSheet({
    String path,
    int rows,
    int cols,
    int textureWidth,
    int textureHeight,
  }) {
    SpriteSheet spriteSheet = SpriteSheet(
      imageName: path,
      textureWidth: textureWidth,
      textureHeight: textureHeight,
      columns: cols,
      rows: rows,
    );

    List<Sprite> sprites = [];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        sprites.add(spriteSheet.getSprite(i, j));
      }
    }

    this.spriteSheetPath = path;
    this.spriteList = sprites;
    this.textureWidth = textureWidth;
    this.textureHeight = textureHeight;
  }

  SpriteGroup.fromProvidedList({
    List<String> spritesPaths,
    int textureWidth,
    int textureHeight,
  }) {
    List<Sprite> sprites = spritesPaths.map((e) => Sprite(e)).toList();
    this.spriteList = sprites;
    this.textureHeight = textureHeight;
    this.textureWidth = textureWidth;
    this.spritePaths = spritesPaths;
  }
}
