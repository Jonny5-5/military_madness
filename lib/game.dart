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
  }
}
