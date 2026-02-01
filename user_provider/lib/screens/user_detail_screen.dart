import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_provider/viewmodels/user_list_view_model.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;
  const UserDetailScreen({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final vm = context.watch<UserListViewModel>();
    final user = vm.users.firstWhere((u) => u.id == userId);
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name : ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email : ${user.email}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () async {
                  final ok = await context.read<UserListViewModel>().deleteUser(
                    userId,
                  );
                  if (context.mounted) {
                    Navigator.pop(context, ok);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
