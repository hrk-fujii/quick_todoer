import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Setting extends StatelessWidget {
  const Setting({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SettingItem(title: "前日通知の時間", widget: PreviousNotifySelector(), description: "やることの締め切り前日の通知を行う時間を設定します。"),
          SettingItem(title: "直前通知の時間", widget: RemindNotifySelector(), description: "やることの締め切り直前の通知を行う時間を設定します。"),
          SettingItem(title: "通知音を有効化", widget: SetNotificationSound(), description: "通知を行うときに音を再生するかどうかを設定します。"),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Widget widget;
  final String description;
  
  const SettingItem({ Key? key, required this.title, required this.widget, required this.description }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ScreenTypeLayout(
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                widget,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(description),
            ),
          ],
        ),
        tablet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                widget,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(description),
            ),
          ],
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                widget,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(description),
            ),
          ],
        ),
        watch: Container(),
      )
    );
  }
}

class PreviousNotifySelector extends StatelessWidget {
  const PreviousNotifySelector({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> selections = [];
    // make the time selection items
    for (int i = 0; i <= 23; i++) {
      selections.add(DropdownMenuItem<int>(
        child: Text('${i}時に通知'),
        value: i,
      ));
    }
    
    return DropdownButton<int>(
      value: 1, 
      items: selections,
      onChanged: (value) => {},
    );
  }
}


class RemindNotifySelector extends StatelessWidget {
  const RemindNotifySelector({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: 5, 
      items: [
        DropdownMenuItem<int>(child: Text("5分前"), value: 5),
        DropdownMenuItem<int>(child: Text("10分前"), value: 10),
        DropdownMenuItem<int>(child: Text("15分前"), value: 15),
        DropdownMenuItem<int>(child: Text("30分前"), value: 30),
        DropdownMenuItem<int>(child: Text("1時間前"), value: 60),
        DropdownMenuItem<int>(child: Text("1時間30分前"), value: 90),
        DropdownMenuItem<int>(child: Text("2時間前"), value: 120),
        DropdownMenuItem<int>(child: Text("3時間前"), value: 180),
      ],
      onChanged: (value) => {},
    );
  }
}


class SetNotificationSound extends StatelessWidget {
  const SetNotificationSound({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: true,
      onChanged: (value) => {}
    );
  }
}
