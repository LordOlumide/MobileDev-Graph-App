import 'package:flutter/material.dart';
import '../UI/screens/home_screen.dart';

class GraphApp extends StatelessWidget {
  const GraphApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Graph App',
        initialRoute: 'Home screen',
        routes: {
            'Home screen': 
        }
    );
  }
}