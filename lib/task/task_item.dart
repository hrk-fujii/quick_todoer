import 'package:flutter/material.dart';


// task list item

// MEMO => done: done.all, doing: forward, yet: remove
class TaskItem extends StatelessWidget {
  const TaskItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "サンプルタスク",
                    style: TextStyle(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "サンプルタスクのサンプル説明。サンプルタスクのサンプル説明。",
                    textAlign: TextAlign.left,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "2022/02/22 22:22 まで。未着手",
                    textAlign: TextAlign.right,
                  ),
                ],
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
