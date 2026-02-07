import 'package:flutter/material.dart';
import 'package:userhub/data/fake_api.dart';
import 'package:userhub/models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  String? _error;
  bool _loading = false;
  List<User> get users => List.unmodifiable(_users);
  bool get isLoading => _loading;
  String? get error => _error;
  Future<void> loadUser() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _users = await fetchUser();
    } catch (e) {
      _error = 'Load user failed';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void updateUser(User updated) {
    final index = _users.indexWhere((u) => u.id == updated.id);
    if (index != -1) {
      _users[index] = updated;
      notifyListeners();
    }
  }

  void deleteUserById(String id) {
    _users.removeWhere((u) => u.id == id);
    notifyListeners();
  }
}
