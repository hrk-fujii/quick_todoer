import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../util/task.dart';
import '../type/firestore.dart';
import '../provider/auth_state_provider.dart';


// edit task item for navigator

class EditTask extends StatelessWidget {
  const EditTask({required this.userData, required this.taskContainer});

  final User? userData;
  final TaskDocumentContainer taskContainer;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: taskContainer.data.name);
    final descriptionController = TextEditingController(text: taskContainer.data.description);
    final deadlineController = TextEditingController(text: dateToNumString(taskContainer.data.deadlineAt));

    void hEdit() async {
      final deadlineAt = numStringToDate(deadlineController.text);
      if (deadlineAt == null || userData == null) {
        return;
      }
      await FirebaseFirestore.instance.collection('users').doc(userData!.uid).collection('tasks').doc(taskContainer.id).update({
        "name": nameController.text,
        "description": descriptionController.text,
        "deadlineAt": Timestamp.fromDate(deadlineAt)
      });
    }

    
    return Scaffold(
      appBar: AppBar(
        title: Text('やることの編集'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text('タイトル :'),
              SizedBox(height: 5),
              TextField(
                controller: nameController,
                maxLength: 100,
                maxLines: 1,
              ),
              SizedBox(height: 10),
              Text('説明 :'),
              SizedBox(height: 5),
              TextField(
                controller: descriptionController,
                maxLength: 500,
                minLines: 10,
                maxLines: 10,
              ),
              SizedBox(height: 10),
              Text('締切時刻 :'),
              SizedBox(height: 5),
              TextField(
                controller: deadlineController,
                maxLength: 12,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Text('タイトルは100文字、説明は500文字までです。'),
              Text('〆切日時の入力は、すべて数字で次のように入力します。'),
              Text('・入力の基本は、年年年年月月日日時時分分の形式です。'),
              Text('・時と分を省略すると23字59分になります。'),
              Text('・分のみを省略すると00分になります。'),
              Text('・年を省略すると本年となります。'),
              Text('・1文字目に9を入力すると、本日を指定できます。'),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('編集確定'),
                onPressed: hEdit,
              ),
            ]
          ),
        ),
      ),
    );
  }
}
