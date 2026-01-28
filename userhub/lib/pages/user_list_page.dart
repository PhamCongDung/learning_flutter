import 'package:flutter/material.dart';
import 'package:userhub/models/user.dart';
import 'package:userhub/data/fake_api.dart';
import 'package:userhub/pages/add_user_page.dart';
import 'package:userhub/pages/user_detail_page.dart';
import 'package:userhub/pages/user_form_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> _futureUsers;
  List<User> _user = [];
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    _futureUsers = fetchUser();
  }

  Future<void> _openDetail(User user) async {
    final deleted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
    );
    if (deleted == true) {
      setState(() {
        _user.removeWhere((u) => u.id == user.id);
      });
    }
  }

  Future<void> _openAddUser() async {
    final newUser = await Navigator.push<User>(
      context,
      // MaterialPageRoute(builder: (_) => const AddUserPage()),
      MaterialPageRoute(builder: (_) => const UserFormPage()),
    );
    if (newUser != null) {
      setState(() {
        _user.add(newUser);
      });
    }
  }

  Future<void> _openEdit(User user) async {
    final updatedUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(builder: (_) => UserFormPage(initialUser: user)),
    );
    if (updatedUser != null) {
      setState(() {
        final index = _user.indexWhere((u) => u.id == updatedUser.id);
        if (index != -1) _user[index] = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _openAddUser),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          }
          final data = snapshot.data!;
          if (!_loaded) {
            _user = List<User>.from(data);
            _loaded = true;
          }
          return ListView.builder(
            itemCount: _user.length,
            itemBuilder: (context, index) {
              final user = _user[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('Age : ${user.age}'),
                onTap: () => _openDetail(user),
                onLongPress: () => _openEdit(user),
              );
            },
          );
        },
      ),
    );
  }
}
