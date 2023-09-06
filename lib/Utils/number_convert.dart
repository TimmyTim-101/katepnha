String convertNumberToString(double d) {
  if ((d - d.round()).abs() <= 0.000001) {
    return d.round().toString();
  } else {
    return d.toString();
  }
}

List<double> separateRate(List<double> r, int n) {
  final List<double> res = [];
  for (int i = 0; i < r.length; i++) {
    res.add(double.parse((r[i] / n).toStringAsFixed(4)));
  }
  return res;
}

String durationConvert(int seconds) {
  final int hour = (seconds / 60 / 60).floor();
  final int minute = ((seconds - hour * 60 * 60) / 60).floor();
  final String hourString = hour == 0 ? '' : '$hour小时';
  final String minuteString = minute == 0 ? '' : '$minute分钟';
  String res = hourString + minuteString;
  if (res == '') {
    res = '1分钟内';
  }
  return res;
}

String timeConvert(DateTime dt) {
  int hour = dt.hour;
  int minute = dt.minute;
  final int second = dt.second;
  if (second >= 30) {
    minute = minute + 1;
  }
  if(minute == 60){
    hour = hour + 1;
    minute = 0;
  }
  final StringBuffer hourString = StringBuffer();
  if (hour < 10) {
    hourString.write('0');
  }
  hourString.write(hour);
  final StringBuffer minuteString = StringBuffer();
  if (minute < 10) {
    minuteString.write('0');
  }
  minuteString.write(minute);
  return '$hourString:$minuteString';
}

String standardTimeString(DateTime dt) {
  final int h = dt.hour;
  final String hs = h < 10 ? '0$h' : h.toString();
  final int m = dt.minute;
  final String ms = m < 10 ? '0$m' : m.toString();
  final int s = dt.second;
  final String ss = s < 10 ? '0$s' : s.toString();
  return '$hs:$ms:$ss';
}
