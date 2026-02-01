import 'package:user_provider/models/user.dart';

class FakeUserApi {
  final List<User> _db = [
    const User(id: '1', name: 'Dung', email: 'phamcongdung92@gmail.com'),
    const User(id: '2', name: 'Thanh', email: 'thanhthanhnguyen@gmail.com'),
    const User(id: '3', name: 'Leo', email: 'leo@gmail.com'),
  ];
  Future<List<User>> fetchUser() async {
    await Future.delayed(const Duration(microseconds: 600));
    return List<User>.unmodifiable(_db);
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(microseconds: 400));
    _db.removeWhere((u) => u.id == id);
  }
}
