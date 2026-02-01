import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_provider/data/repository/user_repository.dart';
import 'package:user_provider/screens/user_detail_screen.dart';
import 'package:user_provider/viewmodels/user_list_view_model.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const _UserListBody();
  }
}

class _UserListBody extends StatelessWidget {
  const _UserListBody();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final vm = context.watch<UserListViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: () => context.read<UserListViewModel>().loadUser(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }
          if (vm.users.isEmpty) {
            return const Center(child: Text('No Users'));
          }
          return ListView.separated(
            itemCount: vm.users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final user = vm.users[i];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                onTap: () async {
                  final deleted = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserDetailScreen(userId: user.id),
                    ),
                  );
                  if (deleted == true) {}
                },
              );
            },
          );
        },
      ),
    );
  }
}
