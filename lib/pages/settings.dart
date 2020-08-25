import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/models/user.dart';
import 'package:maney/pages/widget.dart';
import 'package:maney/models/DbManager.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    DbUserManager dbusermanager = DbUserManager();
    List<User> users;
    print("usernameeeee : ${data["username"]}");

    // var mediaQueryData = MediaQuery.of(context);
    // final cardWidth = mediaQueryData.size.width;
    String showLevel(int level) {
      if (level == 3 || level == 2) {
        print("Administrateur");
        return "Administrateur";
      } else {
        print("Utilisateur");
        return 'Utilisateur';
      }
    }

    String showStatus(int status) {
      print("Administrateur");
      if (status == 1) {
        return "Actif";
      } else {
        return 'Inactif';
      }
    }

    print('settings : data : $data');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(''),
          centerTitle: true,
          // backgroundColor: Colors.deepPurpleAccent[400],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Fonction de Recherche
                // showSearch(context: context, delegate: CustomerItemSearch());
              },
            )
          ],
        ),
        body: FutureBuilder(
          //obtenir la liste
          future: dbusermanager.getListuser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //donnee bien recu
              users = snapshot.data;
              print("*************** info lenght : ${users.length}");
              // print('********* ${infos[0].fullNameOwner}');
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: (users.length == null) ? 0 : users.length,
                  itemBuilder: (BuildContext context, int index) {
                    User user = users[index];

                    user.username = user.username[0].toUpperCase() +
                        user.username.substring(1);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.all(1),
                          elevation: 1,
                          child: ListTile(
                            contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            onTap: () {
                              print("owner : ${user.username}");
                              Navigator.pushNamed(context, '/update_user',
                                  arguments: {
                                    "userData": data,
                                    "userInfo": user
                                  });
                            },
                            leading: Icon(Icons.person),
                            title: Text(
                              '${user.username}',
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text('${showLevel(user.level)}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            trailing: Container(
                              width: 100,
                              height: 250,
                              child: Center(
                                child: Text('${showStatus(user.status)}',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: FlatButton(
              onPressed: () => Navigator.pushNamed(context, '/add_user'),
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
