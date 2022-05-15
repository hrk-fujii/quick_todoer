import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_task.dart';
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
                      child: Text("削除"),
                      onPressed: () {},
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



