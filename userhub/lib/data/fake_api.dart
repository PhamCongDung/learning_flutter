import 'package:userhub/models/user.dart';

Future<List<User>> fetchUser() async {
  await Future.delayed(const Duration(seconds: 2));
  return List.generate(
    10,
    (i) => User(id: 'u$i', name: 'User $i', age: 20 + i),
  );
}
