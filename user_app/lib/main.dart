import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('User App')),
        body: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;
  bool get isHigh => count > 5;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Count : $count',
            style: TextStyle(
              fontSize: isHigh ? 48 : 32,
              fontWeight: isHigh ? FontWeight.bold : FontWeight.normal,
              color: isHigh ? Colors.red : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text('+1'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count == 0 ? count = 0 : count--;
              });
            },
            child: const Text('-1'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count = 0;
              });
            },
            child: const Text('Reset'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(count: count),
                ),
              );
            },
            child: const Text('Go to Detail'),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int count;
  const DetailPage({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Center(
        child: Text(
          'Count from previous page : $count',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
