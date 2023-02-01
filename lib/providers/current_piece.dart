import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../models/piece.dart';
import '../models/pieces.dart';
import '../models/new_piece.dart';

class CurrentPiece extends ChangeNotifier {
  NewPiece? piece;
  Timer? isPlaying;

  final Map<int, Color?> piecesOnGrid = {};

  void setNewPiece() {
    if (piece != null) {
      for (int coordinate in piece!.coordinates) {
        piecesOnGrid[coordinate] = piece!.color;
      }
    }
    checkGrid();
    Piece newPiece = pieces[Random().nextInt(pieces.length)];
    piece = NewPiece(
      coordinates: [...newPiece.coordinates],
      centerPoint: newPiece.centerPoint,
      rotations: newPiece.rotations,
    );
  }

  bool notOnGrid(int coordinate) => !piecesOnGrid.containsKey(coordinate);

  List<int> addSpace(int space) =>
      piece!.coordinates.map((coordinate) => coordinate + space).toList();

  List<int> moveDown() => addSpace(10);

  bool checkDown(List<int> newCoordinates) => newCoordinates
      .every((coordinate) => coordinate < 160 && notOnGrid(coordinate));

  List<int> moveLeft() => addSpace(-1);

  bool checkLeft(List<int> oldCoordinates) =>
      oldCoordinates.every((coordinate) =>
          (coordinate.remainder(10) - 1) >= 0 && notOnGrid(coordinate - 1));

  List<int> moveRight() => addSpace(1);

  bool checkRight(List<int> oldCoordinates) =>
      oldCoordinates.every((coordinate) =>
          (coordinate.remainder(10) + 1) <= 9 && notOnGrid(coordinate + 1));

  Map<String, int> getXAndY(int num) {
    int centerPoint = piece!.coordinates[piece!.centerPoint];
    return {
      "x": num.remainder(10) - (centerPoint).remainder(10),
      "y": ((centerPoint ~/ 10) - (num ~/ 10))
    };
  }

  int rotateXandY(Map<String, int> coordinate) {
    int centerPoint = piece!.coordinates[piece!.centerPoint];
    int x = centerPoint + (coordinate["y"] as int);
    int y = (coordinate["x"] as int) * 10;
    return x + y;
  }

  List<int> rotate() => piece!.coordinates
      .map((coordinate) => rotateXandY(getXAndY(coordinate)))
      .toList();

  bool checkRotate(List<int> oldCoordinates) =>
      oldCoordinates.every((coordinate) => notOnGrid(coordinate + 9));

  void move(String direction) {
    if (piece == null) {
      setNewPiece();
    } else {
      switch (direction) {
        case "down":
          List<int> newCoordinates = moveDown();
          if (checkDown(newCoordinates)) {
            piece!.coordinates = newCoordinates;
          } else {
            setNewPiece();
          }
          break;
        case "right":
          if (checkRight(piece!.coordinates)) {
            List<int> newCoordinates = moveRight();
            piece!.coordinates = newCoordinates;
          }
          break;
        case "left":
          if (checkLeft(piece!.coordinates)) {
            List<int> newCoordinates = moveLeft();
            piece!.coordinates = newCoordinates;
          }
          break;
        case "rotate":
          List<int> newCoordinates = rotate();
          if (checkRotate(newCoordinates)) {
            piece!.coordinates = newCoordinates;
          }

          break;
      }
    }
    notifyListeners();
  }

  void checkGrid() {
    if (piecesOnGrid.isEmpty) return;
    List<int> keysToRemove = [];

    for (int i = 0; i < 160; i += 10) {
      List<int> subKeysToRemove = [];
      for (int j = i; j < (i + 10); j++) {
        if (piecesOnGrid.containsKey(j)) {
          subKeysToRemove.add(j);
        }
      }

      if (subKeysToRemove.length == 10) keysToRemove.addAll(subKeysToRemove);
    }

    if (keysToRemove.isEmpty) return;

    for (int key in keysToRemove) {
      piecesOnGrid[key] = Colors.grey[200];
    }
    notifyListeners();
    Timer(const Duration(milliseconds: 50), () {
      for (int key in keysToRemove) {
        piecesOnGrid.remove(key);
      }

      int first = keysToRemove[0];

      for (int i = first; i >= 0; i--) {
        if (piecesOnGrid.containsKey(i)) {
          piecesOnGrid[i + keysToRemove.length] = piecesOnGrid[i];
          piecesOnGrid.remove(i);
        }
      }

      notifyListeners();
    });
  }

  void play() {
    if(isPlaying != null) {
      isPlaying!.cancel();
      isPlaying = null;
      notifyListeners();
    } else {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      isPlaying = timer;
      move("down");
    });
    }
  }
}
