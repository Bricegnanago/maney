import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _level = TextEditingController();
  final _status = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List _statusList = ['Inactif', 'Actif'];
  String _currentLevel;
  List _levelList = ['Adminitrateur', 'Utilisateur'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Mise à jour compte')),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: TextFormField(controller: _username,),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: TextFormField(controller: _username,),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
