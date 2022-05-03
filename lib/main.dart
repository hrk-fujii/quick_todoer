import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import "firebase_options.dart";
import 'app_home.dart';

// providers
import 'provider/auth_state_provider.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthStateProvider>(
            create: (context) => AuthStateProvider(),
          ),
          //ChangeNotifierProvider<TasksProvider>(
            //create: (context) => TasksProvider(),
          //),
        ],
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (context.select((AuthStateProvider authState) => authState.connectionState) != snapshot.connectionState || context.select((AuthStateProvider authState) => authState.userData) != snapshot.data) {
              Future(() {
                context.read<AuthStateProvider>().setAuthState(
                  user: snapshot.data,
                  connection: snapshot.connectionState
                );
              });
            }
            return const AppHome();
          },
        ),
      ),
    );
  }
}


