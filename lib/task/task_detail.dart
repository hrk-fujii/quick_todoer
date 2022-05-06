import 'package:flutter/material.dart';

// task item detail for navigation


class TaskDetail extends StatelessWidget {
  const TaskDetail({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "サンプルタスク",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text("説明 :"),
                SizedBox(height: 5),
                Text("サンプルタスクの説明。サンプルタスクの説明。サンプルタスクの説明。"),
                SizedBox(height: 10),
                Text("締切日時 : 2022/02/22 22:22"),
                SizedBox(height: 10),
                Text("最終更新日時 : 2022/02/22 10:22"),
                SizedBox(height: 10),
                Text("作成日時 : 2022/02/20 22:20"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("編集"),
                      onPressed: () {},
                    ),
                    RaisedButton(
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



