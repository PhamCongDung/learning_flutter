import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      home: Scaffold(
        appBar: AppBar(title: const Text('User App')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Flutter', style: TextStyle(fontSize: 50)),
              SizedBox(height: 100),
              Text('Day 1 Completed', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
