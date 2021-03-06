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


class TaskDetail extends StatefulWidget {
  @override

late TaskDocumentContainer task;
final User? authUserData;

TaskDetail(this.task, this.authUserData);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Widget build(BuildContext context) {
    // button handler
    void hEdit() async {
      final result = await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => EditTask(
          taskContainer: widget.task,
          userData: widget.authUserData,
        )
      ));
      // update view if returned task document
      if (result is TaskDocument) {
        setState(() {
          widget.task = TaskDocumentContainer(id: widget.task.id, data: result);
        });
      }
    }

    void hChecklist() async {
      if (widget.authUserData == null) {
        return;
      }
      await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => Checklist(
          taskContainer: widget.task,
          authUser: widget.authUserData!,
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
              Text(widget.task.data.name),
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
        if (widget.authUserData != null) {
          FirebaseFirestore.instance.collection('users').doc(widget.authUserData!.uid).collection('tasks').doc(widget.task.id).delete();
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
                  widget.task.data.name,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text("説明 :"),
                SizedBox(height: 5),
                Text(widget.task.data.description),
                SizedBox(height: 10),
                Text("状態 : " + ((widget.task.data.state == TaskDocument.STATE_DONE) ? 
                  "すでに完了しています。"
                : (widget.task.data.state == TaskDocument.STATE_DOING) ?
                  "現在、実施中です。"
                : //else
                  "まだ未着手です。"
                )),
                SizedBox(height: 10),
                Text("〆切日時 : " + dateToString(widget.task.data.deadlineAt, DATE_RESULTTYPE_JP)),
                SizedBox(height: 10),
                Text("最終更新日時 : " + dateToString(widget.task.data.updatedAt, DATE_RESULTTYPE_JP)),
                SizedBox(height: 10),
                Text("作成日時 : " + dateToString(widget.task.data.createdAt, DATE_RESULTTYPE_JP)),
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



