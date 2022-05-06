import 'package:flutter/material.dart';

import 'task_item.dart';
// tasks list view

class Task extends StatelessWidget {
  const Task({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TaskItem(),
          TaskItem(),
          TaskItem()
        ],
      ),
    );
  }
}
