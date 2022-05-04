import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/dialog.dart';

// This screen used for not signed in only.

class Signin extends StatelessWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget SigninUiInstance = new SigninUI();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ログイン"),
      ),
      body: ScreenTypeLayout(
        mobile: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DescriptionMessage(),
                SigninUiInstance,
              ],
            ),
          ),
        ),
        tablet: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _DescriptionMessage(),
              SigninUiInstance,
            ],
          ),
        ),
        desktop: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _DescriptionMessage(),
              SigninUiInstance,
            ],
          ),
        ),
        watch: Container(),
      ),
    );
  }
}


class _DescriptionMessage extends StatelessWidget {
  const _DescriptionMessage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Quick Todoer へようこそ！",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text("はじめるには、ログインします。パスワードを忘れた場合は、メールアドレスを使ってパスワードをリセットできます。アカウントをまだお餅でなければ、新しいアカウントを作成してください。"),
        ],
      ),
    );
  }
}

class SigninUI extends StatefulWidget {
  const SigninUI({ Key? key }) : super(key: key);

  @override
  State<SigninUI> createState() => _SigninUIState();
}

class _SigninUIState extends State<SigninUI> {
  // input text
  String _email = "";
  String _password = "";

  
  // set input text

  void _hChangeEmail(String value) {
    setState(() {
      _email = value;
    });
  }

  void _hChangePassword(String value) {
    setState(() {
      _password = value;
    });
  }

  // end set input text
  

  // Signin
  void hSignin() async {
    showFullScreenLoadingDialog(
      context: context,
      message: "ログイン中...",
    );
    await new Future.delayed(new Duration(seconds: 3));
    Navigator.of(context, rootNavigator: true).pop();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text("メールアドレス")
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: _hChangeEmail,
            )
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text("パスワード")
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TextField(
              obscureText: true,
              onChanged: _hChangePassword,
            )
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: RaisedButton(
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text("ログイン"),
                ),
                onPressed: hSignin,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(
                child: Text("パスワードリセット"),
                onPressed: () {},
              ),
              OutlineButton(
                child: Text("アカウント作成"),
                onPressed: () {},
              ),
            ],
          )
        ],
      )
    );
  }
}
