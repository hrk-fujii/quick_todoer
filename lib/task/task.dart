import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_item.dart';
import '../provider/auth_state_provider.dart';
import '../provider/tasks_provider.dart';


// tasks list view

class Task extends StatelessWidget {
  const Task({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.select((AuthStateProvider authState) => authState.userData) == null) {
      return Center(
        child: Text("開始するには、設定画面よりログインしてください。"),
      );
    }

    if (context.select((TasksProvider tasks) => tasks.hasError)) {
      return Center(
        child: Text("やることリストの取得に失敗しました。時間をおいて、再度試してみてください。"),
      );
    }

    List<Widget> taskListItems = context.select((TasksProvider tasks) => tasks.docs).map((task) => TaskItem(task)).toList();

    return Container(
      child: ListView(
        children: taskListItems,
      ),
    );
  }
}
