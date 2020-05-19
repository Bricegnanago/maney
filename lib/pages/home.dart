import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Text(
          'Bienvenudos',
          style: TextStyle(
          fontSize: 30
          )
        ),
      ),
    );
  }
}