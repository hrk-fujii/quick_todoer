import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../type/firestore.dart';

// this provider has task collections.


class TasksProvider extends ChangeNotifier {
  List<TaskDocumentContainer> docs = [];
  ConnectionState connection = ConnectionState.waiting;
  bool hasError = false;

  void setError() {
    docs = [];
    hasError = true;
    notifyListeners();
  }

  void setDocs(List<TaskDocumentContainer>? taskContainers) {
    if (taskContainers != null) {
      docs = taskContainers;
    } else {
      docs = [];
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
