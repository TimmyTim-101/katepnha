import 'package:flutter/material.dart';
import 'SubScreen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'KatepиHa',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        fontFamily: 'hywh',
      ),
      routes: {
        '/': (context) => const HomeScreen(),
      },
    ),
  );
}
