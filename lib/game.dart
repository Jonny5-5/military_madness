import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MainGame extends FlameGame with HasGameRef, ScaleDetector, TapDetector {
  static const scale = 1.0;
  late TiledComponent mapComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    camera.viewfinder
      ..zoom = _startZoom
      ..anchor = Anchor.center;

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

  static const double _minZoom = 0.5;
  static const double _maxZoom = 2.0;
  double _startZoom = _minZoom;

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    if (currentScale.isIdentity()) {
      _processDrag(info);
    } else {
      _processScale(info, currentScale);
    }
  }

  void _processScale(ScaleUpdateInfo info, Vector2 currentScale) {
    final newZoom = _startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }

  void _processDrag(ScaleUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 / _startZoom;
    final currentPosition = camera.viewfinder.position;

    camera.viewfinder.position = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    // _checkScaleBorders();
    // _checkDragBorders();
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;

    final currentPosition = camera.viewfinder.position;

    final mapSize = Offset(mapComponent.width, mapComponent.height);

    var xTranslate = 0.0;
    var yTranslate = 0.0;

    if (worldRect.topLeft.dx < 0.0) {
      xTranslate = -worldRect.topLeft.dx;
    } else if (worldRect.bottomRight.dx > mapSize.dx) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx;
    }

    if (worldRect.topLeft.dy < 0.0) {
      yTranslate = -worldRect.topLeft.dy;
    } else if (worldRect.bottomRight.dy > mapSize.dy) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy;
    }

    camera.viewfinder.position =
        currentPosition.translated(xTranslate, yTranslate);
  }
}
