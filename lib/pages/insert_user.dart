import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';
// import 'package:maney/models/DbManager.dart';

class AdminNewUser extends StatefulWidget {
  @override
  _AdminNewUserState createState() => _AdminNewUserState();
}

class _AdminNewUserState extends State<AdminNewUser> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _passwordConfirmController = TextEditingController();
    print("usernameeeee : ${data["username"]}");
    _usernameController.text = data["username"];
    // _passwordController.text = data["password"];
    // User user;
    // final _formKey = GlobalKey<FormState>();
    // DbUserManager dbusermanager = DbUserManager();
    var mediaQueryData = MediaQuery.of(context);
    final cardWidth = mediaQueryData.size.width;
    print('settings : data : $data');
    return Scaffold(
        appBar: AppBar(
          title: Text("Gérer les comptes"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 30),
                      child: Text(
                        'Parametrage du compte',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 20),
                      ),
                    ),
                    Form(
                      key: _scaffoldKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _usernameController,
                              // initialValue: data["username"],
                              decoration: InputDecoration(
                                hintText: 'Nom utilisateur',
                                labelText: 'Nom utilisateur',
                              ),
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              // initialValue: data["username"],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Mot de passe actuel',
                                labelText: 'Mot de passe actuel',
                              ),
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              // initialValue: data["password"],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: _passwordConfirmController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Nouveau mot de passe',
                                labelText: 'Nouveau mot de passe',
                              ),
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                            ),
                          ),
                          Container(
                              // color: Colors.deepPurple,
                              width: cardWidth * 0.9,
                              margin: EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                                color: Colors.deepPurple,
                                child: Text(
                                  'Enregistrer',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => null,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/admin_newUser'),
              child: Icon(
                Icons.group_add,
                color: Colors.white,
              )),
        ),
        drawer: DrawerWidget(
          userData: data["username"],
        ));
  }
}
