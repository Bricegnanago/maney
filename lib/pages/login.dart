import 'package:maney/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:maney/models/user.dart';
import 'package:maney/models/DbManager.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
   final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  // User user;
  final _formKey = GlobalKey<FormState>();
  DbUserManager dbusermanager = DbUserManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Connectez-vous",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      validator: (value) => value.isNotEmpty
                                          ? null
                                          : "Ce champs est requis",
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Email ou Numéro de téléphone",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 18)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      validator: (value) => value.isNotEmpty
                                          ? null
                                          : "Ce champs est requis",
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Mot de passe",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 18)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          FlatButton(
                            color: Colors.white,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Text(
                                  "Connexion",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onPressed: () {                              
                                submitUser(context);                                
                                // print('Hello world');
                            },
                          )),
                      SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Mot de Passe oublié",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void submitUser(BuildContext context) {
    if (_formKey.currentState.validate()) {
      //afficher un snackbar si l'utilsateur existe déjà
      
      //recupération des données
      User user = User(username: _usernameController.text, password: _passwordController.text);    
      
      // print("username : ${user.username}");
      // print("username :");
      _usernameController.clear();
      _passwordController.clear();
      dbusermanager.isLogged(user).then((id) {
        if (id) {
          Navigator.pushReplacementNamed(
              context, '/home', arguments: {
                "username" : user.username
              }); //accès à la page d'acceuil
          print('Acces autorise');
        } else {
          // msg = "Connexion échouée";
          // final snackBar = SnackBar(
          //   content: Text(msg),
          //   action: SnackBarAction(
          //     label: 'Cacher',
          //     onPressed: () {
          //       // Some code to undo the change.
          //     },
          //   ),
          // );
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              elevation: 10,
              content: Text("Données d'authentification incorrecte",
              textAlign: TextAlign.center , 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,                                
              ),
              ),
              backgroundColor: Colors.redAccent,            
              ),
          );
          print("Acces refuse");
          
        }
      // });

      // dbusermanager.insertUser(user).then((id) {
      //   if(id>0){
      //     print("identifiant : : $id");
      //   }else{
      //     print("Une erreur");
      //   }
            
          // print('Acces refuse');
          // Scaffold.of(context).showSnackBar(snackBar);
      });
    }
  }
}
