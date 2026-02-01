import 'package:flutter/material.dart';
import 'package:user_provider/data/repository/user_repository.dart';
import 'package:user_provider/models/user.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository repo;
  UserListViewModel(this.repo);
  bool loading = false;
  String? error;
  List<User> users = [];
  Future<void> loadUser() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      users = await repo.getUser();
    } catch (e) {
      error = 'Load users failed';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await repo.removeUser(id);
      users.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    } catch (_) {
      error = 'Delete failed';
      notifyListeners();
      return false;
    }
  }
}
