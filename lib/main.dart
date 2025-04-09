import 'package:bloodintern/view/homescreenpages/hospital%20list.dart';
import 'package:bloodintern/view/splash.dart';
import 'package:flutter/material.dart';
List<String> notifications = [];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash()
    );
  }
}

