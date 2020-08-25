import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maney/models/DbManager.dart';
import 'package:maney/models/user.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _username = TextEditingController();
  final _password = TextEditingController();
    User newUser = User(username: null, password: null);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  DbUserManager dbUserManager = DbUserManager();
  int _levelValue = 1;
  int _statusValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Nouvel Utilisateur')),
      body: SingleChildScrollView(
          child: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextFormField(
                    controller: _username,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Champ de saisie obligatoire",
                    decoration: InputDecoration(
                        hintText: 'Nom utilisateur',
                        labelText: 'Nom utilisateur',
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: TextFormField(
                    obscureText: true,
                    controller: _password,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Champ de saisie obligatoire",
                    decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        hintText: 'Mot de passe',
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: DropdownButtonFormField(
                      value: _levelValue,
                      items: <DropdownMenuItem<int>>[
                        DropdownMenuItem(
                          child: Text('Super Administrateur'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('Administrateur'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('Utlisateur'),
                          value: 1,
                        )
                      ],
                      onChanged: (int value) {
                        print(value);
                        _levelValue = value;
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: DropdownButtonFormField(
                      value: _statusValue,
                      items: <DropdownMenuItem<int>>[
                        DropdownMenuItem(
                          child: Text('Actif'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('Inactif'),
                          value: 0,
                        ),
                      ],
                      onChanged: (int value) {
                        print(value);
                        _statusValue = value;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            onPressed: () {
                              _username.clear();
                              _password.clear();
                            },
                            child: Text(
                              "Annuler",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFFd9534f),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            onPressed: () {
                              addUser();
                            },
                            child: Text(
                              "Enregistrer",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      )),
    );
  }

  // add user function
  void addUser() {
    if (_formKey.currentState.validate()) {
      //initialisation de la class user
    
      newUser.username = _username.text;
      newUser.password = _password.text;
      newUser.status = _statusValue;
      newUser.level = _levelValue;
      DateFormat formatter = DateFormat('dd-MM-yyyy');      
      newUser.lastUpdate = formatter.format(DateTime.now());

      dbUserManager.insertUser(newUser).then((value) => print('L\'identifiant de l\'utilisateur inseré est : $value'));
    }
  }
}
