import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_piece.dart';
import '../models/new_piece.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentPiece currentPiece = Provider.of<CurrentPiece>(context);
    NewPiece? piece = currentPiece.piece;
    Map<int, Color?> piecesOnGrid = currentPiece.piecesOnGrid;

    return GridView.builder(
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: piece != null && piece.coordinates.contains(index)
                ? piece.color
                : piecesOnGrid.containsKey(index)
                    ? piecesOnGrid[index]
                    : Colors.black,
            borderRadius: BorderRadius.circular(4)),
      ),
      itemCount: 160,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
    );
  }
}
