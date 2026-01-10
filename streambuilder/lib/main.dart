import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Timer')),
        body: const TimerPage(),
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final _controller = StreamController<int>();
  int count = 0;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<int>(
            stream: _controller.stream,
            initialData: count,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Text(
                '${snapshot.data}',
                style: const TextStyle(fontSize: 32),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              count++;
              _controller.add(count);
            },
            child: const Text('+1'),
          ),
          ElevatedButton(
            onPressed: () {
              count--;
              _controller.add(count);
            },
            child: const Text('-1'),
          ),
        ],
      ),
    );
  }
}
