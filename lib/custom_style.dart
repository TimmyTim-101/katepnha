import 'package:flutter/material.dart';

// 颜色相关

Color backColor() {
  return const Color.fromRGBO(10, 20, 50, 1.0);
}

Color frontColor() {
  return const Color.fromRGBO(40, 50, 80, 1.0);
}

Color selectedColor() {
  return const Color.fromRGBO(60, 70, 100, 1.0);
}

Color buttonSelectedColor() {
  return const Color.fromRGBO(235, 179, 11, 1);
}

Color buttonUnselectedColor() {
  return const Color.fromRGBO(100, 117, 139, 1);
}

Color lackColor() {
  return const Color.fromRGBO(251, 113, 133, 1);
}

Color unLackColor() {
  return const Color.fromRGBO(18, 185, 129, 1.0);
}

Color noCanCompleteColor() {
  return const Color.fromRGBO(140, 140, 140, 1.0);
}

Color mergeColor() {
  return const Color.fromRGBO(185, 136, 35, 1);
}

Color getStarBackgroundColor(int i) {
  if (i == 1) {
    return const Color.fromRGBO(121, 122, 124, 1);
  } else if (i == 2) {
    return const Color.fromRGBO(93, 140, 121, 1);
  } else if (i == 3) {
    return const Color.fromRGBO(94, 129, 160, 1);
  } else if (i == 4) {
    return const Color.fromRGBO(132, 106, 161, 1);
  } else if (i == 5) {
    return const Color.fromRGBO(191, 132, 65, 1);
  }
  return Colors.transparent;
}

// 文字相关

Widget customDivider() {
  return const Divider(
    height: 20,
    thickness: 1,
    indent: 10,
    endIndent: 10,
    color: Colors.white10,
  );
}

Widget customText(String str, [Color color = Colors.white, double size = 20]) {
  return Text(
    str,
    style: TextStyle(
      color: color,
      fontFamily: 'hywh',
      fontSize: size,
    ),
  );
}
