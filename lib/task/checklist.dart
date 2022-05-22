import 'package:flutter/material.dart';
import '../type/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// check list for navigator

class Checklist extends StatelessWidget {
  final User authUser;
  final TaskDocumentContainer taskContainer;
  
  const Checklist({required this.taskContainer, required this.authUser});
  
  @override
  Widget build(BuildContext context) {
    // text controller
    final addItemTextController = TextEditingController();
    
    // button handler
    void hAdd() async {
      final collectionRef = FirebaseFirestore.instance.collection("users").doc(authUser.uid).collection("tasks").doc(taskContainer.id).collection("checklist");
      collectionRef.add(ChecklistItemDocument(
        name: addItemTextController.text,
        isDone: false
      ).toNewFirestore());
    }
    // end button handler
    
    return StreamBuilder<QuerySnapshot<Map<String, Object?>>?>(
      stream: FirebaseFirestore.instance.collection("users").doc(authUser.uid).collection("tasks").doc(taskContainer.id).collection("checklist").snapshots(),
      builder: (context, snapshot) {
        List<Widget> items = [];
        if (snapshot.data != null) {
          items = snapshot.data!.docs.map((element) => _ChecklistItem(
            taskContainer: taskContainer,
            itemContainer: ChecklistItemDocumentContainer(
              data: ChecklistItemDocument.fromFirestore(element.data()),
              id: element.id
            ),
            authUser: authUser
          )).toList();
        } else {
          items = [];
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("チェックリスト"),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder()
                        ),
                        controller: addItemTextController,
                        maxLength: 100,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text("追加"),
                      onPressed: hAdd,
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: items,
                    ),
                  ),
                ),
                Text("現在オフライン"),
              ],
            ),
          ),
        );
      }
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final User authUser;
  final TaskDocumentContainer taskContainer;
  final ChecklistItemDocumentContainer itemContainer;
  const _ChecklistItem({required this.itemContainer, required this.taskContainer, required this.authUser});

  void hCheckbox(bool? value) {
    if (value == null) {
      return;
    }
    final documentRef = FirebaseFirestore.instance.collection('users').doc(authUser.uid).collection('tasks').doc(taskContainer.id).collection('checklist').doc(itemContainer.id);
    documentRef.update({
      "isDone": value,
      "updatedAt": FieldValue.serverTimestamp()
    });
  }

  void hDelete() {
    final documentRef = FirebaseFirestore.instance.collection('users').doc(authUser.uid).collection('tasks').doc(taskContainer.id).collection('checklist').doc(itemContainer.id);
    documentRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: itemContainer.data.isDone,
            onChanged: hCheckbox,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(itemContainer.data.name),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: hDelete,
            child: Text("削除")
          ),
        ],
      ),
    );
  }
}
