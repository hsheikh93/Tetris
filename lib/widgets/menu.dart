import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_piece.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentPiece currentPiece = Provider.of<CurrentPiece>(context);
    return Container(
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: currentPiece.play,
              child: Text(currentPiece.isPlaying == null ? "Play" : "Pause"),
            ),
            ElevatedButton(
              onPressed: currentPiece.isPlaying != null
                  ? () => currentPiece.move("left")
                  : null,
              child: const Text("Left"),
            ),
            ElevatedButton(
              onPressed: currentPiece.isPlaying != null
                  ? () => currentPiece.move("right")
                  : null,
              child: const Text("Right"),
            ),
            ElevatedButton(
              onPressed: currentPiece.isPlaying != null
                  ? () => currentPiece.move("rotate")
                  : null,
              child: const Text("Rotate"),
            ),
          ],
        ));
  }
}
