import 'package:flutter/material.dart';
// import 'package:circular_profile_avatar/circular_profile_avatar.dart';

// import 'package:cached_network_image/cached_network_image.dart';
class DrawerWidget extends StatelessWidget {
  final String userData;

  DrawerWidget({this.userData});
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
      var mediaQueryData = MediaQuery.of(context);
    final cardWidth = mediaQueryData.size.width;
    print('drawer : data : $data');
    return SafeArea(      
          child: Drawer(            
        child: ListView(        
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0),            
              duration: Duration(
                seconds: 2,              
              ),

              child: Container(
                width: cardWidth,
                
                color: Colors.deepPurpleAccent[400],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data["username"], style: TextStyle(fontSize: 30,  color: Colors.white),)
                  ],
                  
                )
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 16,
              ),
              title: Text(
                'Accueil',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/home',
                    arguments: data);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.date_range,
                size: 16,
              ),
              title: Text(
                'Historique',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                //Redirection vers la page des historique
                Navigator.popAndPushNamed(context, '/story',
                    arguments: data);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.equalizer,
                size: 16,
              ),
              title: Text(
                'Statisque',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.popAndPushNamed(context, '/analytics',
                    arguments: data);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 16,
              ),
              title: Text(
                'Paramètre',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/settings',
                    arguments: data);
              },
            ),
            SizedBox(
              height: 100,
            ),
            ListTile(
              leading: Icon(
                Icons.settings_power,
                size: 16,
              ),
              title: Text('Deconnexion', style: TextStyle(fontSize: 16)),
              onTap: () {
                //L'utilisateur se déconnecte

                Navigator.popAndPushNamed(
                  context,
                  '/login',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
