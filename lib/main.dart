import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Todoer',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:ThemeMode.system,
      home: AppHome(),
    );
  }
}


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
    Text("home"),
    Text("setting"),
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
