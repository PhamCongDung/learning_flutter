import 'package:flutter/material.dart';
import 'package:userhub/models/user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('${user.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID : ${user.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Name : ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Age : ${user.age}', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
