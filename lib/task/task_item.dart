import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_todoer/provider/auth_state_provider.dart';

import 'task_detail.dart';
import '../type/firestore.dart';
import '../util/date.dart';

// task list item

// MEMO => done: done.all, doing: forward, yet: remove
class TaskItem extends StatelessWidget {
  @override
  
  final TaskDocumentContainer task;
  
  TaskItem(this.task);
  
  Widget build(BuildContext context) {
    final User? authUser = context.select((AuthStateProvider authState) => authState.userData);
    
    // on tap right side.
    void hDetail() async {
      await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => TaskDetail(task)
      ));
    }

    // update task's state
    void hUpdateState(int taskTo) async {
      if (authUser == null) {
        return;
      }
      final documentRef = FirebaseFirestore.instance.collection('users').doc(authUser.uid).collection('tasks').doc(task.id);
      debugPrint("DEBUG_LOG: kita!!");
      await documentRef.update({"state": taskTo, "updatedAt": FieldValue.serverTimestamp()});
      debugPrint("DEBUG_LOG: kitaKita!!");
    }
    
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ((task.data.state == TaskDocument.STATE_DONE) ?
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.done_all,
                  semanticLabel: "完了した" + task.data.name,
                  size: 50
                ),
              )
            : (task.data.state == TaskDocument.STATE_DOING) ?
              IconButton(
                onPressed: (){hUpdateState(TaskDocument.STATE_DONE);},
                icon: Icon(
                  Icons.forward,
                  semanticLabel: "実施中の" + task.data.name,
                  size: 50
                ),
              )
            : //else
              IconButton(
                onPressed: (){hUpdateState(TaskDocument.STATE_DOING);},
                icon: Icon(
                  Icons.remove,
                  semanticLabel: "未着手の" + task.data.name,
                  size: 50
                ),
              )
            ),
            SizedBox(width: 10),
            Expanded(
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      task.data.name,
                      style: TextStyle(fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      task.data.description,
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      dateToString(task.data.deadlineAt) + "まで。 "
                      + ((task.data.state == TaskDocument.STATE_DONE) ?
                        "(完了)"
                      : (task.data.state == TaskDocument.STATE_DOING) ?
                        "(実施中)"
                      : //else
                        "(未着手)"
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                onTap: hDetail,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
