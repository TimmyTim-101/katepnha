import 'package:flutter/material.dart';
import 'SubScreen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: '原神补全计划',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        fontFamily: 'hywh',
      ),
      routes: {
        '/': (context) => HomeScreen(),
      },
    ),
  );
}
