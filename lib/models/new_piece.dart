import 'dart:math';
import "package:flutter/material.dart";

List<Color?> colors = [
  Colors.red,
  Colors.pink,
  Colors.blue,
  Colors.amber,
  Colors.lime,
  Colors.orange
];

class NewPiece {
  List<int> coordinates;
  final int centerPoint;
  final int rotations;
  Color? color = colors[Random().nextInt(colors.length)];

  NewPiece({
    required this.coordinates,
    required this.centerPoint,
    required this.rotations,
  });
}
