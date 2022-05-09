// task utils

DateTime? numStringToDate(String value) {
  int year = 0;
  int month = 0;
  int day = 0;
  int hour = 0;
  int minute = 0;
  
  // is number
  if (RegExp(r'[0-9]+').hasMatch(value) == false) {
    return null;
  }

  
  // input full year
  if (value.substring(0, 2) == "20") {
    if ((value.length == 8 || value.length == 10 || value.length == 12)
      && int.parse(value.substring(4, 6)) >= 1 && int.parse(value.substring(4, 6)) <= 12
      && int.parse(value.substring(6, 8)) >= 1
    ) {
      year = int.parse(value.substring(0, 4));
      month = int.parse(value.substring(4, 6));
      day = int.parse(value.substring(6, 8));
      if (day > DateTime(year, month + 1, 1).add(Duration(days: -1)).day) {
        return null;
      }
      hour = 23;
      minute = 59;
      if (value.length == 10 && int.parse(value.substring(8, 10)) >= 0 && int.parse(value.substring(8, 10)) <= 23) {
        hour = int.parse(value.substring(8, 10));
        minute = 00;
      } else if (value.length == 10) {
        return null;
      }
      if (value.length == 12 && int.parse(value.substring(10, 12)) >= 0 && int.parse(value.substring(10, 12)) <= 59) {
        minute = int.parse(value.substring(10, 12));
      } else if (value.length == 12) {
        return null;
      }
      return DateTime(year, month, day, hour, minute);
    } else {
      return null;
    }
  
  // 01 - 12 is set this year
  } else if (int.parse(value.substring(0, 2)) >= 1 && int.parse(value.substring(0, 2)) <= 12) {
    if ((value.length == 4 || value.length == 6 || value.length == 8)
      && int.parse(value.substring(2, 4)) >= 1
    ) {
      year = DateTime.now().year;
      month = int.parse(value.substring(0, 2));
      day = int.parse(value.substring(2, 4));
      if (day > DateTime(year, month + 1, 1).add(Duration(days: -1)).day) {
        return null;
      }
      hour = 23;
      minute = 59;
      if (value.length == 6 && int.parse(value.substring(4, 6)) >= 0 && int.parse(value.substring(4, 6)) <= 23) {
        hour = int.parse(value.substring(4, 6));
        minute = 0;
      } else if (value.length == 6) {
        return null;
      }
      if (value.length == 8 && int.parse(value.substring(6, 8)) >= 0 && int.parse(value.substring(6, 8)) <= 59) {
        minute = int.parse(value.substring(6, 8));
      } else if (value.length == 8) {
        return null;
      }
      return DateTime(year, month, day, hour, minute);
    } else {
      return null;
    }
  
  // 9 is this date
  } else if (value[0] == "9") {
    if (value.length == 3 || value.length == 5) {
      final nowDate = DateTime.now();
      year = nowDate.year;
      month = nowDate.month;
      day = nowDate.day;
      if (value.length == 3 && int.parse(value.substring(1, 3)) >= 0 && int.parse(value.substring(1, 3)) <= 23) {
        hour = int.parse(value.substring(1, 3));
        minute = 0;
      } else if (value.length == 3) {
        return null;
      }
      if (value.length == 8 && int.parse(value.substring(3, 5)) >= 0 && int.parse(value.substring(3, 5)) <= 59) {
        minute = int.parse(value.substring(3, 5));
      } else if (value.length == 5) {
        return null;
      }
      return DateTime(year, month, day, hour, minute);
    } else {
      return null;
    }
  }
  return null;
}


String dateToNumString(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, "0");
  String day = date.day.toString().padLeft(2, "0");
  String hour = date.hour.toString().padLeft(2, "0");
  String minute = date.minute.toString().padLeft(2, "0");
  return year + month + day + hour + minute;
}
