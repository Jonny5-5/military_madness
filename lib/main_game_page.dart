import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'game.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  MainGame game = MainGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: game,
      ),
    );
  }
}
