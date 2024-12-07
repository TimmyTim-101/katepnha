import 'package:katepnha/BaseData/global_vars.dart';

DateTime getNowDateTime(){
  final DateTime now = DateTime.now();
  final DateTime utcNow = now.toUtc();
  final DateTime utcPlus = utcNow.add(Duration(hours: utcOffset));
  return utcPlus;
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
