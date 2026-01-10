import 'dart:async';

import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _count = 0;
  bool get _isRunning => _timer?.isActive == true;
  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _count++;
      _controller.add(_count);
    });
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    super.initState();
    _controller.add(_count);
  }

  @override
  void dispose() {
    _stop();
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
            builder: (context, snapshot) {
              final value = snapshot.data ?? 0;
              return Text(
                'Total Users : $value',
                style: const TextStyle(fontSize: 48),
              );
            },
          ),
          //          const SizedBox(height: 20),
          //         Text(_isRunning ? 'Running' : 'Stopped'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _start, child: const Text('Start')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: _stop, child: const Text('Stop')),
            ],
          ),
          const SizedBox(height: 20),
          Text(_isRunning ? 'Running' : 'Stopped'),
        ],
      ),
    );
  }
}
