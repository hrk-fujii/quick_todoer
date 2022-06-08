import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'setting.dart';
import 'auth.dart';
import 'user_setting.dart';
import '../type/firestore.dart';
import '../provider/auth_state_provider.dart';


class UserSettingItem extends StatelessWidget {
  const UserSettingItem({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    User? signedinUserData = context.select((AuthStateProvider authState) => authState.userData);
    UserDocument? signedInUserDocument = context.select((AuthStateProvider authState) => authState.documentData);
    return SettingItem(
      title: "ログイン中のユーザー",
      widget: (context.select((AuthStateProvider authState) => authState.connectionState) == ConnectionState.waiting) ?
        Center(
          child: CircularProgressIndicator(),
        )
      : ((context.select((AuthStateProvider authState) => authState.userData) != null) ?
        ElevatedButton(
          child: Text("ユーザーの設定"),
          onPressed: ()async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) => UserSetting()
            ));
          }
        )
      : // else
        ElevatedButton(
          child: Text("ログイン"),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) => Signin()
            ));
          },
        )
      ),
      description: (context.select((AuthStateProvider authState) => authState.connectionState) == ConnectionState.waiting) ?
        "ログイン状態を確認しています..."
      : ((signedinUserData != null) ?
        ((signedInUserDocument == null) ?
          'ようこそ。ユーザー情報の確認や編集、ログアウトを行うには、ユーザーの設定をタップしてください。'
        : // else
          'ようこそ。' + signedInUserDocument.name + 'ユーザー情報の確認や編集、ログアウトを行うには、ユーザーの設定をタップしてください。'
        )
      : // else
        "Quick Todoer を利用するには、ログインしてください。"
      ),
    )    ;
  }
}

