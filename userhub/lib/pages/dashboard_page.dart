import 'package:flutter/material.dart';
import 'package:userhub/pages/user_list_page.dart';
import 'package:userhub/pages/dashboard_controller.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late final DashboardController controller;
  @override
  void initState() {
    super.initState();
    controller = DashboardController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: StreamBuilder<DashboardState>(
        stream: controller.stream,
        initialData: controller.current,
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
                  ElevatedButton(
                    onPressed: controller.start,
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: controller.stop,
                    child: const Text('Stop'),
                  ),
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
