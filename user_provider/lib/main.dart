import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_provider/data/api/fake_user_api.dart';
import 'package:user_provider/data/repository/user_repository.dart';
import 'package:user_provider/screens/user_list_screen.dart';
import 'package:user_provider/viewmodels/user_list_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => UserRepository(FakeUserApi())),
        ChangeNotifierProvider(
          create: (context) =>
              UserListViewModel(context.read<UserRepository>())..loadUser(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: const UserListScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
