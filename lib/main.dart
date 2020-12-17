import 'package:NewLock/pages/Home_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "lock",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

