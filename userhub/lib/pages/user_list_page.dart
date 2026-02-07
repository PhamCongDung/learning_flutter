import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userhub/models/user.dart';
import 'package:userhub/data/fake_api.dart';
import 'package:userhub/pages/add_user_page.dart';
import 'package:userhub/pages/user_detail_page.dart';
import 'package:userhub/pages/user_form_page.dart';
import 'package:userhub/pages/user_provider.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});
  Future<void> _openAddUser(BuildContext context) async {
    final newUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(builder: (_) => const UserFormPage()),
    );
    if (newUser != null) {
      context.read<UserProvider>().addUser(newUser);
    }
  }

  Future<void> _openEdit(BuildContext context, User user) async {
    final updated = await Navigator.push<User>(
      context,
      MaterialPageRoute(builder: (_) => UserFormPage(initialUser: user)),
    );
    if (updated != null) {
      context.read<UserProvider>().updateUser(updated);
    }
  }

  Future<void> _openDetail(BuildContext context, User user) async {
    final deleted = Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
    );
    if (deleted == true) {
      context.read<UserProvider>().deleteUserById(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: provider.loadUser),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return const Center(child: Text('Error loading users'));
          }
          final users = provider.users;
          if (users.isEmpty) {
            return const Center(child: Text('No User'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('Age : ${user.age}'),
                onTap: () => _openDetail(context, user),
                onLongPress: () => _openEdit(context, user),
              );
            },
          );
        },
      ),
    );
  }
}
