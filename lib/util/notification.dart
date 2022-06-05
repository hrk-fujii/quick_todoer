import '../type/firestore.dart';
import 'shared_preferences.dart';
import 'local_notification.dart';
import 'date.dart';


Future<void> setNotificationFromTaskDocumentContainers({required List<TaskDocumentContainer>? taskContainers}) async {
  await cancelLocalNotification();
  if (taskContainers == null) {
    return;
  }
  final remindEnable = await getBoolPreference(key: PREFERENCES_REMIND_NOTIFICATION_ENABLE, defaultValue: true);
  final beforeEnable = await getBoolPreference(key: PREFERENCES_BEFORE_NOTIFICATION_ENABLE, defaultValue: true);
  final remindMinute = await getIntPreference(key: PREFERENCES_REMIND_NOTIFICATION_MINUTE, defaultValue: 5);
  final beforeHour = await getIntPreference(key: PREFERENCES_BEFORE_NOTIFICATION_TIME_HOUR, defaultValue: 23);
  taskContainers.forEach((element) async {
    if (remindEnable == true) {
      final date = element.data.deadlineAt.add(Duration(minutes: remindMinute) * -1);
      await scheduleNotification(
        title: element.data.name,
        body: dateToString(element.data.deadlineAt) + "まで\n" + element.data.description,
        dateTime: date
      );
    }
    if (beforeEnable == true) {
      final date = element.data.deadlineAt.add(Duration(days: 1) * -1);
      final newDate = DateTime(date.year, date.month, date.day, beforeHour, 0);
      await scheduleNotification(
        title: "[明日] " + element.data.name,
        body: dateToString(element.data.deadlineAt) + "まで\n" + element.data.description,
        dateTime: newDate
      );
    }
  });
}
