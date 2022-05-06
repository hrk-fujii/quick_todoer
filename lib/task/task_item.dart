import 'package:flutter/material.dart';


// task list item

// MEMO => done: done.all, doing: forward, yet: remove
class TaskItem extends StatelessWidget {
  const TaskItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.remove,
                semanticLabel: "未着手",
                size: 50
              ),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  "サンプルタスク",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  "サンプルタスクのサンプル説明。",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text("2022/02/22 22:22 まで。現在未着手"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
