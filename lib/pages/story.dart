import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';


class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique d'activité"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent[400],
      ),
      body: Center(
        child: Text(
          "Activité hebdomadaire",
          style: TextStyle(
          fontSize: 30
          )
        ),
      ),
      drawer: DrawerWidget()
    );
  }
}