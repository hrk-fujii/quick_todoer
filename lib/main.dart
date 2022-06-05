import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import "firebase_options.dart";
import 'app_home.dart';

// providers
import 'provider/auth_state_provider.dart';
import 'provider/tasks_provider.dart';

// firebase data converter
import 'type/firestore.dart';

// local notification utils
import 'util/local_notification.dart';
import 'util/notification.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalNotification();
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
    const appHomeInstance = AppHome();
    
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
          ChangeNotifierProvider<TasksProvider>(
            create: (context) => TasksProvider(),
          ),
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
            if (snapshot.data == null) {
              return appHomeInstance;
            }
            return StreamBuilder<QuerySnapshot<Map<String, Object?>>?>(
              stream: FirebaseFirestore.instance.collection("users").doc((snapshot.data != null)? snapshot.data!.uid : "").collection("tasks").snapshots(),
              builder: (context, snapshot) {
                Future(() {
                  if (snapshot.hasError) {
                    context.read<TasksProvider>().setError();
                  } else {
                    final containers = (snapshot.data != null) ? snapshot.data!.docs.map((documentSnapshot) {
                      return TaskDocumentContainer(id: documentSnapshot.id, data: TaskDocument.fromFirestore(documentSnapshot.data()));
                    }).whereType<TaskDocumentContainer>().toList() : null;
                    setNotificationFromTaskDocumentContainers(taskContainers: containers);
                    context.read<TasksProvider>().setHasPendingWrites((snapshot.data != null) ? snapshot.data!.metadata.hasPendingWrites : null);
                    context.read<TasksProvider>().setDocs(containers);
                    context.read<TasksProvider>().setConnectionState(snapshot.connectionState);
                  }
                });
                return appHomeInstance;
              }
            );
          },
        ),
      ),
    );
  }
}


