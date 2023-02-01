import 'package:flutter/material.dart';

import './widgets/grid.dart';
import './widgets/menu.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          flex: 9,
          child: Grid(),
        ),
        Expanded(flex: 1, child: Menu()),
      ],
    );
  }
}
