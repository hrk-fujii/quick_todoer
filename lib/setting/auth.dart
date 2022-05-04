import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/dialog.dart';

// This screen used for not signed in only.

class Signin extends StatelessWidget {
  const Signin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget SigninUiInstance = SigninUI();
    
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
              Expanded(child: _DescriptionMessage()),
              Expanded(child: SigninUiInstance),
            ],
          ),
        ),
        desktop: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _DescriptionMessage()),
              Expanded(child: SigninUiInstance),
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // Signin
  void hSignin() async {
    showFullScreenLoadingDialog(
      context: context,
      message: "ログイン中...",
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(error.code);
    }
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
              controller: emailController,
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
              controller: passwordController,
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
