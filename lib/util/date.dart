// date time util

const int DATE_RESULTTYPE_SLASH = 0;
const int DATE_RESULTTYPE_JP = 1;
const Map<int, String> DATE_DAYSTRING_JP = {
  1: "月", 2: "火", 3: "水", 4: "木", 5: "金", 6: "土", 7: "日",
};


String dateToString(DateTime dateTime, [int resultType = 0]) {
  if (resultType == DATE_RESULTTYPE_SLASH) {
    return (
      dateTime.year.toString() + "/" +
      dateTime.month.toString().padLeft(2, "0") + "/" +
      dateTime.day.toString().padLeft(2, "0") + " " +
      dateTime.hour.toString().padLeft(2, "0") + ":" +
      dateTime.minute.toString().padLeft(2, "0")
    );
  } else if (resultType == DATE_RESULTTYPE_JP) {
    return (
      dateTime.year.toString() + "年" +
      dateTime.month.toString() + "月" +
      dateTime.day.toString() + "日" +
      DATE_DAYSTRING_JP[dateTime.weekday]! + "曜日 " +
      dateTime.hour.toString() + "時" +
      dateTime.minute.toString() + "分"
    );
  } else {
    return dateTime.toIso8601String();
  }
}