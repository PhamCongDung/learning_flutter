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
            onPressed: () async {
              final shouldReset = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(count: count, isHigh: isHigh),
                ),
              );
              if (shouldReset == true) {
                setState(() {
                  count = 0;
                });
              }
            },
            child: const Text('Go to Detail'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(count: count),
                ),
              );
            },
            child: const Text('SettingPage'),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final int count;
  final bool isHigh;
  const DetailPage({super.key, required this.count, required this.isHigh});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isHigh ? 'Count is High : $count' : 'Count is NORMAL : $count',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Reset Count'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  final int count;
  const SettingPage({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Setting Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count is : $count', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
