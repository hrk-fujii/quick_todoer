import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_task.dart';
import 'checklist.dart';
import '../type/firestore.dart';
import '../util/date.dart';
import '../provider/auth_state_provider.dart';

// task item detail for navigation


class TaskDetail extends StatelessWidget {
  @override

final TaskDocumentContainer task;
final User? authUserData;

TaskDetail(this.task, this.authUserData);

  Widget build(BuildContext context) {
    // button handler
    void hEdit() async {
      await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => EditTask(
          taskContainer: task,
          userData: authUserData,
        )
      ));
    }

    void hChecklist() async {
      if (authUserData == null) {
        return;
      }
      await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => Checklist(
          taskContainer: task,
          authUser: authUserData!,
        )
      ));
    }
    
    void hDelete() async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("やることの削除"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("このやることを削除しますか？"),
              SizedBox(height: 20,),
              Text(task.data.name),
            ],
          ),
          actions: [
            SimpleDialogOption(
              child: Text("いいえ"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            SimpleDialogOption(
              child: Text("はい"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
      if (result == true) {
        // delete and back
        if (authUserData != null) {
          FirebaseFirestore.instance.collection('users').doc(authUserData!.uid).collection('tasks').doc(task.id).delete();
        }
        Navigator.pop(context);
      }
    }
    // end button handler


    return Scaffold(
      appBar: AppBar(
        title: Text("やることの詳細"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("タイトル :"),
                SizedBox(height: 5),
                Text(
                  task.data.name,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text("説明 :"),
                SizedBox(height: 5),
                Text(task.data.description),
                SizedBox(height: 10),
                Text("状態 : " + ((task.data.state == TaskDocument.STATE_DONE) ? 
                  "すでに完了しています。"
                : (task.data.state == TaskDocument.STATE_DOING) ?
                  "現在、実施中です。"
                : //else
                  "まだ未着手です。"
                )),
                SizedBox(height: 10),
                Text("〆切日時 : " + dateToString(task.data.deadlineAt, DATE_RESULTTYPE_JP)),
                SizedBox(height: 10),
                Text("最終更新日時 : " + dateToString(task.data.updatedAt, DATE_RESULTTYPE_JP)),
                SizedBox(height: 10),
                Text("作成日時 : " + dateToString(task.data.createdAt, DATE_RESULTTYPE_JP)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text("編集"),
                      onPressed: hEdit,
                    ),
                    ElevatedButton(
                      child: Text("チェックリスト"),
                      onPressed: hChecklist,
                    ),
                    ElevatedButton(
                      child: Text("削除"),
                      onPressed: hDelete,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}



