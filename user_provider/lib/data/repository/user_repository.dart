import 'package:user_provider/data/api/fake_user_api.dart';
import 'package:user_provider/models/user.dart';

class UserRepository {
  final FakeUserApi api;
  UserRepository(this.api);
  Future<List<User>> getUser() => api.fetchUser();
  Future<void> removeUser(String id) => api.deleteUser(id);
}
