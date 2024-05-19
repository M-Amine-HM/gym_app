import 'package:flutter/material.dart';
import 'package:gym_app/auth/firstPage.dart';
import 'package:gym_app/providers/checked_provider.dart';
import 'package:gym_app/providers/timer_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CheckedProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider())
      ],
      child: MaterialApp(
        title: 'Gym App',
        home: FirstPage(),
      ),
    );
  }
}
