import 'package:flame/game.dart';
import 'package:flutter/widgets.dart' hide Animation, Image;
import 'package:military_madness/game.dart';

void main() {
  runApp(
    SafeArea(
      child: GameWidget(
        game: MainGame(),
      ),
    ),
  );
}
