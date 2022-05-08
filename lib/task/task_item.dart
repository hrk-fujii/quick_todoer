import 'package:flutter/material.dart';

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
    // on tap right side.
    void hDetail() async {
      await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => TaskDetail()
      ));
    }
    
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.remove,
                semanticLabel: "未着手の" + task.data.name,
                size: 50
              ),
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
                      dateToString(task.data.deadlineAt) + "まで。現在未着手",
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
