import 'package:flutter/material.dart';
import '../type/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// check list for navigator

class Checklist extends StatefulWidget {
  const Checklist({Key? key}) : super(key: key);

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("チェックリスト"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final User? authUser;
  final ChecklistItemDocumentContainer itemContainer;
  const _ChecklistItem({required this.itemContainer, required this.authUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Checkbox(
            value: itemContainer.data.isDone,
            onChanged: null,
          ),
          SizedBox(width: 10),
          Text(itemContainer.data.name),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {},
            child: Text("削除")
          ),
        ],
      ),
    );
  }
}
