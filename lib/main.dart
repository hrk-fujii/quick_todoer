import 'package:flutter/material.dart';

import 'app_home.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Todoer',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:ThemeMode.system,
      home: AppHome(),
    );
  }
}


