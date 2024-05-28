import '../exports/common_lib.dart';

///@author lihonghao
///@date 2022/9/26
///@description
extension StringExt on String {
  int getDays() {
    return difference().inDays;
  }

  int getSeconds() {
    return difference().inSeconds;
  }

  int getHours() {
    return difference().inHours;
  }

  Duration difference() {
    var d1 = DateUtil.getDateTime(this)!;
    var d2 = DateTime.now();
    return d2.difference(d1);
  }

  String getDateStr() {
    var d1 = DateUtil.getDateTime(this)!;
    var d2 = DateTime.now();
    Duration duration = d1.difference(d2);
    int s = duration.inSeconds;

    int day = (s / (3600 * 24)).floor();
    s = (s - day * (3600 * 24));
    int hour = (s / 3600).floor();
    s = (s - (hour * 3600));
    int minutes = (s / 60).floor();
    s = s - (minutes * 60);
    StringBuffer time = StringBuffer();
    if (day != 0) {
      time.write('$day天');
    }
    if (hour != 0) {
      time.write('$hour时');
    }
    if (minutes != 0) {
      time.write('$minutes分');
    }
    if (s != 0) {
      time.write('$s秒');
    }
    return time.toString();
  }
}
