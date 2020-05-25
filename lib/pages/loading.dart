import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:maney/pages/login.dart';
// import 'package:maney/models/DbManager.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  @override
  Widget build(BuildContext context) {
    // DbUserManager db = DbUserManager();
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      navigateAfterSeconds: Login(),
      image: new Image.asset(
          'assets/images/loading.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}

