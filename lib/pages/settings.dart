import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  @override
  Widget build(BuildContext context) {
  final Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gérer les comptes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent[400],
      ),
      body: Center(
        child: Text(
          "Gerer les comptes",
          style: TextStyle(
          fontSize: 30
          )
        ),
      ),
      drawer: DrawerWidget(userData: data["username"],)
    );
  }
}