import 'package:flutter/material.dart';
import 'app/UI/home_screen.dart';
import 'app/constants/app_theme.dart';

class GraphApp extends StatelessWidget {
  const GraphApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph App',
      home: const HomeScreen(),
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      ),
    );
  }
}
