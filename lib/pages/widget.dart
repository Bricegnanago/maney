import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final String userData;

  
  DrawerWidget({this.userData});
  @override
  Widget build(BuildContext context) {    
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(          
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(                            
              child: Text('Profil : $userData',style: TextStyle(
                color: Colors.white,
                fontSize: 30
              ),),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent[200],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box, size: 22,),
              title: Text('Mon Compte', style: TextStyle(
                fontSize : 22
              ),),
              onTap: () {
                
                Navigator.pop(context);
                //redirection vers la page d'accueil
                Navigator.popAndPushNamed(context, '/home');

              },
            ),
            ListTile(
              leading: Icon(Icons.date_range, size: 22,),              
              title: Text('Historique', style: TextStyle(
                fontSize : 22
              ),),
              onTap: () {              
                //Redirection vers la page des historique
                Navigator.popAndPushNamed(context, '/story');
              },
            ),
            ListTile(
              leading: Icon(Icons.equalizer, size: 22,),
              title: Text('Statisque', style: TextStyle(
                fontSize : 22
              ),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer                
                Navigator.popAndPushNamed(context, '/analytics');
              },
              
            ),
            ListTile(
              leading: Icon(Icons.settings, size: 22,),
              title: Text('Paramètre', style: TextStyle(
                fontSize : 22
              ),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/settings');
              },
              
            ),
            SizedBox(height: 100,),
            ListTile(
              leading: Icon(Icons.settings_power, size: 22,),
              title: Text('Deconnexion',
              style: TextStyle(
                fontSize : 22
                )),
              onTap: () {
                //L'utilisateur se déconnecte
  
                Navigator.popAndPushNamed(context, '/login');
              },
            )
          ],
        ),
    
    );
  }
}