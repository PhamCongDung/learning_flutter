import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userhub/pages/dashboard_page.dart';
import 'package:userhub/pages/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider()..loadUser(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DashBoard Page')),
        body: const DashBoardPage(),
      ),
    );
  }
}
