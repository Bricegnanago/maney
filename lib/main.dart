import 'package:flutter/material.dart';
import 'package:maney/pages/home.dart';
import 'package:maney/pages/loading.dart';
import 'package:maney/pages/analytics.dart';
import 'package:maney/pages/login.dart';
// import 'package:maney/pages/';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute : '/',
      routes: {
        '/' : (context) => Loading(),
        '/home': (context) => Home(),
        '/analytics': (context) => Analytics(),
        '/login': (context) => Login(),
      },
    );
  }
}