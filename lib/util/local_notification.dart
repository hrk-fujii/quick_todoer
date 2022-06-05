import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


Future<FlutterLocalNotificationsPlugin> initializeLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification
        );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // onSelectNotification: selectNotification
    );
    return flutterLocalNotificationsPlugin;
}


Future<void> scheduleNotification({required String title, required String body, required DateTime dateTime, FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin}) async {
    // set the plugin
    if (flutterLocalNotificationsPlugin == null) {
      flutterLocalNotificationsPlugin = await initializeLocalNotification();
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);
    final tzDateTime = tz.TZDateTime.from(dateTime, location);
    if (tzDateTime.isBefore(tz.TZDateTime.now(location))) {
      return;
    }
    final idString = DateTime.now().microsecond.toString() + math.Random().nextInt(999).toString();
    final id = int.parse(idString);


    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title, body,
        tzDateTime,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description'
            )
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
}

Future<void> cancelLocalNotification() async {
    final  flutterLocalNotificationsPlugin = await initializeLocalNotification();
    await flutterLocalNotificationsPlugin.cancelAll();
}
