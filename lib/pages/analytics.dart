import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
      print('analytics : data username : ${data["username"]}');

    return Scaffold(
        appBar: AppBar(
          title: Text('Analyse des données'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
        ),
        body: Center(
          child: Text('Analyse statistiques',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
        ),
        drawer: DrawerWidget(
          userData: data["username"],
        ));
  }
}
