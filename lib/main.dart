import 'package:flutter/material.dart';
import 'package:todo_list/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: Colors.purple,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
