import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../type/firestore.dart';

// this provider has task collections.

class TasksProvider extends ChangeNotifier {
  List<TaskDocument> data = [];
  ConnectionState connection = ConnectionState.waiting;
  bool hasError = false;

  void setError() {
    data = [];
    hasError = true;
    notifyListeners();
  }

  void setData(List<TaskDocument>? snapshotsData) {
    if (snapshotsData != null) {
      data = snapshotsData;
    } else {
      data = [];
    }
    hasError = false;
    notifyListeners();
  }

  setConnectionState(connectionState) {
    connection = connectionState;
    hasError = false;
    notifyListeners();
  }
}
