import 'package:flutter/material.dart';

// user settings for navigator

class UserSetting extends StatelessWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ユーザー情報の確認・編集"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("表示名"),
                  ElevatedButton(
                    child: Text("変更を確定"),
                    onPressed: (){},
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TextField(
                maxLength: 50,
                decoration: InputDecoration(hintText: "表示名 (例: example)"),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("メールアドレス"),
                  ElevatedButton(
                    child: Text("変更を確定"),
                    onPressed: (){},
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TextField(
                maxLength: 256,
                decoration: InputDecoration(hintText: "メールアドレス (例: ex@example.com)"),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("パスワード"),
                  ElevatedButton(
                    child: Text("変更を確定"),
                    onPressed: (){},
                  ),
                ],
              ),
              SizedBox(height: 10,),
              TextField(
                maxLength: 16,
                decoration: InputDecoration(hintText: "パスワード"),
              ),
              SizedBox(height: 10,),
              TextField(
                maxLength: 16,
                decoration: InputDecoration(hintText: "パスワードの確認"),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
