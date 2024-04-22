import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MainGame extends FlameGame with HasGameRef, TapDetector {
  static const scale = 1.0;
  late TiledComponent mapComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    mapComponent = await TiledComponent.load(
      "level1.tmx",
      Vector2.all(64),
    );

    add(mapComponent);

    // final flameIsometric = await FlameIsometric.create(
    //   tileMap: 'tile_map.png',
    //   tmx: 'tiles/level1.tmx',
    // );

    // for (var i = 0; i < flameIsometric.layerLength; i++) {
    //   add(
    //     IsometricTileMapComponent(
    //       flameIsometric.tileset,
    //       flameIsometric.matrixList[i],
    //       destTileSize: flameIsometric.srcTileSize,
    //       position:
    //           Vector2(gameSize.x / 2, flameIsometric.tileHeight.toDouble()),
    //     ),
    //   );
    // }
  }
}
