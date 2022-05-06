import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../type/firestore.dart';


// This provider has firebase authentication states.
class AuthStateProvider extends ChangeNotifier {
  User? userData;
  ConnectionState connectionState = ConnectionState.waiting;
  UserDocument? documentData;

  // setAuthState
  void setAuthState ({required User? user, required ConnectionState connection}) async {
    final db = FirebaseFirestore.instance;
    // try get user data document or make.
    if (user != null && connection == ConnectionState.active) {
      final userDocumentRef = db.collection("users").doc(user.uid).withConverter<UserDocument>(
        fromFirestore: (snapshot, _) => UserDocument.fromFirestore(snapshot.data()!),
        toFirestore: (userDocument, _) => userDocument.toNewFirestore(),
      );
      try {
        final snapshot = await userDocumentRef.get();
        if (snapshot.exists) {
          documentData = snapshot.data();
        } else {
          await userDocumentRef.set(UserDocument(user.email!));
          final reLoadSnapshot = await userDocumentRef.get();
          documentData = reLoadSnapshot.data();
        }
      } catch (error) {
        FirebaseAuth.instance.signOut();
      }
    }
    userData = user;
    connectionState = connection;
    notifyListeners();
  }
}
