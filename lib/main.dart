import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import "firebase_options.dart";
import 'app_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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


