import 'dart:async';

import 'package:flutter/material.dart';
import 'package:userhub/pages/user_list_page.dart';

class DataStream {
  final int count;
  final bool isRunning;
  const DataStream({required this.count, required this.isRunning});
}

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final StreamController<DataStream> _controller =
      StreamController<DataStream>();
  Timer? _timer;
  int _count = 0;
  bool get _isRunning => _timer?.isActive == true;
  void _emit() {
    _controller.add(DataStream(count: _count, isRunning: _isRunning));
  }

  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _count++;
      _emit();
    });
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
    _emit();
  }

  @override
  void initState() {
    super.initState();
    _emit();
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
      child: StreamBuilder<DataStream>(
        stream: _controller.stream,
        initialData: DataStream(count: _count, isRunning: _isRunning),
        builder: (context, snapshot) {
          final state = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Users : ${state.count}',
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 20),
              Text(
                'Status : ${state.isRunning ? 'Running' : 'Stopped'}',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _start, child: const Text('Start')),
                  const SizedBox(width: 12),
                  ElevatedButton(onPressed: _stop, child: const Text('Stop')),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserListPage()),
                  );
                },
                child: const Text('Open User List'),
              ),
              //          const SizedBox(height: 20),
              //          Text(
              //            'Status : ${_isRunning ? 'Running' : 'Stopped'}',
              //            style: TextStyle(fontSize: 24),
              //          ),
            ],
          );
        },
      ),
    );
  }
}
