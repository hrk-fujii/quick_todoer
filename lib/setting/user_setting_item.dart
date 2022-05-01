import 'package:flutter/material.dart';

import 'setting.dart';
import 'auth.dart';


class UserSettingItem extends StatelessWidget {
  const UserSettingItem({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SettingItem(
      title: "ユーザー設定",
      widget: RaisedButton(
        child: Text("ログイン"),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) => Signin()
          ));
        },
      ),
      description: "Quick Todoer を利用するには、ログインしてください。",
    )    ;
  }
}

