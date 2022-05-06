import 'package:flutter/material.dart';

import 'task/task.dart';
import 'setting/setting.dart';

class AppHome extends StatefulWidget {
  const AppHome({ Key? key }) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  
  // set screen from navigation bar
  int currentNavigationIndex = 1;
  void setCurrentNavigationIndex(int index) {
    setState(() {
      currentNavigationIndex = index;
    });
  }


  // screen list
  List<Widget> screens = [
    Task(),
    Setting(),
    Text("info"),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Todoer"),
      ),
      body: screens[currentNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavigationIndex,
        onTap: setCurrentNavigationIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            activeIcon: Icon(Icons.checklist_outlined),
            label: "やること",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings_outlined),
            label: "設定",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            activeIcon: Icon(Icons.info_outline),
            label: "アプリ情報",
          ),
        ]
      ),
    );
  }
}
