import 'package:shared_preferences/shared_preferences.dart';

// getter

Future<bool> getBoolPreference({required String key, required bool defaultValue}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final result = await sharedPreferences.getBool(key) ?? defaultValue;
  return result;
}

Future<int> getIntPreference({required String key, required int defaultValue}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final result = await sharedPreferences.getInt(key) ?? defaultValue;
  return result;
}

Future<String> getStringPreference({required String key, required String defaultValue}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final result = await sharedPreferences.getString(key) ?? defaultValue;
  return result;
}

// end getter


// setter

void setBoolPreference({required String key, required bool value}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(key, value);
}

void setIntPreference({required String key, required int value}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt(key, value);
}

void setStringPreference({required String key, required String value}) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value);
}

// end setter


// keys
const String PREFERENCES_REMIND_NOTIFICATION_ENABLE = "remindNotificationEnable";
const String PREFERENCES_REMIND_NOTIFICATION_MINUTE = "remindNotificationMinute";
const String PREFERENCES_BEFORE_NOTIFICATION_ENABLE = "beforeNotificationEnable";
const String PREFERENCES_BEFORE_NOTIFICATION_TIME_HOUR = "beforeNotificationTimeHour";
