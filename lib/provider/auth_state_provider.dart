import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This provider has firebase authentication states.
class AuthStateProvider extends ChangeNotifier {
  User? userData = null;
  ConnectionState connectionState = ConnectionState.waiting;

  // setAuthState
  void setAuthState({User? user, ConnectionState connection}){
    userData = user;
    connectionState = connection;
    notifyListeners();
  }
}
