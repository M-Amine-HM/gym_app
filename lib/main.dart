import 'package:flutter/material.dart';
import 'package:gym_app/auth/firstPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      home: FirstPage(),
    );
  }
}
