import 'package:flutter/material.dart';
import '../services/decoder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    getDecodedFile();

    return const Scaffold(
      body: Center(
        child: Text('Home screen'),
      ),
    );
  }
}
