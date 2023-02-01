import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/current_piece.dart';

import './game_board.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.white),
        scaffoldBackgroundColor: Colors.grey[900],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            disabledForegroundColor: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => CurrentPiece(),
          builder: (context, child) => const GameBoard(),
        ),
      ),
    );
  }
}
