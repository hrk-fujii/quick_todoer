import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'setting.dart';
import 'auth.dart';
import '../type/firestore.dart';
import '../provider/auth_state_provider.dart';


class UserSettingItem extends StatelessWidget {
  const UserSettingItem({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SettingItem(
      title: "ユーザー設定",
      widget: (context.select((AuthStateProvider authState) => authState.connectionState) == ConnectionState.waiting) ?
        Center(
          child: CircularProgressIndicator(),
        )
      : ((context.select((AuthStateProvider authState) => authState.userData) != null) ?
        RaisedButton(
          child: Text("設定"),
          onPressed: (){}
        )
      : // else
        RaisedButton(
          child: Text("ログイン"),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) => Signin()
            ));
          },
        )
      ),
      description: "Quick Todoer を利用するには、ログインしてください。",
    )    ;
  }
}

