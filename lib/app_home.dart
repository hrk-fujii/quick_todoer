import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth_state_provider.dart';
import 'task/task.dart';
import 'task/add_task.dart';
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



  @override
  Widget build(BuildContext context) {
      // screen list
    List<Widget> screens = [
      Task(),
      Setting(),
      Text("info"),
    ];

    // actions list
    List<List<Widget>?> actionLists = [
      [
        AddTaskButton(),
      ],
      null,
      null,
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Todoer"),
        actions: actionLists[currentNavigationIndex],
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

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = context.select((AuthStateProvider authState) => authState.userData);
    if (userData == null) {
      return IconButton(
        icon: Icon(Icons.add),
        onPressed: null,
      );
    }
    return IconButton(
      onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => AddTask(userData: userData)
      ));
      },
      icon: Icon(Icons.add, semanticLabel: 'やることを追加'),
    );
  }
}
