import 'package:flutter/material.dart';
import 'package:memory_game/app_theme.dart';
import 'package:memory_game/game_manager.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Game',
      theme: appTheme,
      home: ChangeNotifierProvider(
        create: (context) => GameManager(),
        child: const Material(child: HomeScreen()),
      ),
    );
  }
}
