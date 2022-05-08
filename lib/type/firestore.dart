import 'package:cloud_firestore/cloud_firestore.dart';

// firestore document class



class UserDocument {
  // initialized by client
  UserDocument(this.name) {
    this.updatedAt = DateTime.now();
    this.createdAt = DateTime.now();
  }

  // initialized by firebase
  UserDocument.fromFirestore(Map<String, Object?> json) {
    this.name = json["name"]! as String;
    this.updatedAt = (json["updatedAt"]! as Timestamp).toDate();
    this.createdAt = (json["createdAt"]! as Timestamp).toDate();
  }
  
  late String name;
  late DateTime updatedAt;
  late DateTime createdAt;

  // getter for firebase
  Map<String, Object?> toNewFirestore() {
    return {
      "name": name,
      "updatedAt": FieldValue.serverTimestamp(),
      "createdAt": FieldValue.serverTimestamp()
    };
  }
}



class CheckListItemDocument {
  // initialized by client
  CheckListItemDocument({required this.name, this.isChecked = false}) {
    this.updatedAt = DateTime.now();
    this.createdAt = DateTime.now();
  }

  // initialized by firebase
  CheckListItemDocument.fromFirestore(Map<String, Object?> json) {
    this.name = json["name"]! as String;
    this.isChecked = json["isChecked"]! as bool;
    this.updatedAt = (json["updatedAt"]! as Timestamp).toDate();
    this.createdAt = (json["createdAt"]! as Timestamp).toDate();
  }

  late String name;
  late bool isChecked;
  late DateTime updatedAt;
  late DateTime createdAt;

  // getter for firebase
  Map<String, Object?> toNewFirestore() {
    return {
      "name": name,
      "isChecked": isChecked,
      "updatedAt": FieldValue.serverTimestamp(),
      "createdAt": FieldValue.serverTimestamp()
    };
  }
}


class TaskDocumentContainer {
  final String id;
  final TaskDocument data;

  TaskDocumentContainer({required this.id, required this.data});
}


class TaskDocument {
  // initialized by client
  TaskDocument({required this.name, required this.description, required this.deadlineAt, this.state = TaskDocument.STATE_YET, this.type = TaskDocument.TYPE_NORMAL}) {
    this.updatedAt = DateTime.now();
    this.createdAt = DateTime.now();
  }

  // initialized by firebase
  TaskDocument.fromFirestore(Map<String, Object?> json) {
    this.name = json["name"]! as String;
    this.description = json["description"]! as String;
    this.state = json["state"]! as int;
    this.type = json["type"]! as int;
    this.deadlineAt = (json["deadlineAt"]! as Timestamp).toDate();
    this.updatedAt = (json["updatedAt"]! as Timestamp).toDate();
    this.createdAt = (json["createdAt"]! as Timestamp).toDate();
  }

  // document values
  late String name;
  late String description;
  late int state;
  late int type;
  late DateTime deadlineAt;
  late DateTime updatedAt;
  late DateTime createdAt;

  
  // constants
  static const int STATE_YET = 0;
  static const int STATE_DOING = 1;
  static const int STATE_DONE = 2;
  static const int TYPE_NORMAL = 0;
  
  // getter for firebase
  Map<String, Object?> toNewFirestore() {
    return {
      "name": name,
      "description": description,
      "state": state,
      "type": type,
      "deadlineAt": Timestamp.fromDate(deadlineAt),
      "updatedAt": FieldValue.serverTimestamp(),
      "createdAt": FieldValue.serverTimestamp()
    };
  }
}
