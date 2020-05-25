import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

// import 'package:cached_network_image/cached_network_image.dart';
class DrawerWidget extends StatelessWidget {
  final String userData;

  DrawerWidget({this.userData});
  @override
  Widget build(BuildContext context) {
    return Drawer(      
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(            
            child: CircularProfileAvatar(
              'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
              radius: 40, // sets radius, default 50.0
              backgroundColor: Colors
                  .transparent, // sets background color, default Colors.white
              borderWidth: 5, // sets border, default 0.0
              initialsText: Text(
                "Samy",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ), // sets initials text, set your own style, default Text('')
              borderColor:
                  Colors.brown, // sets border color, default Colors.white
              elevation:
                  5.0, // sets elevation (shadow of the profile picture), default value is 0.0
              foregroundColor: Colors.brown.withOpacity(
                  0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
              cacheImage:
                  true, // allow widget to cache image against provided url
              onTap: () {
                print('adil');
              }, // sets on tap
              showInitialTextAbovePicture:
                  true, // setting it true will show initials text above profile picture, default false
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_box,
              size: 22,
            ),
            title: Text(
              'Mon Compte',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              //redirection vers la page d'accueil
              // Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.date_range,
              size: 22,
            ),
            title: Text(
              'Historique',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              //Redirection vers la page des historique
              Navigator.popAndPushNamed(context, '/story');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.equalizer,
              size: 22,
            ),
            title: Text(
              'Statisque',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.popAndPushNamed(context, '/analytics');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 22,
            ),
            title: Text(
              'Paramètre',
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/settings');
            },
          ),
          SizedBox(
            height: 100,
          ),
          ListTile(
            leading: Icon(
              Icons.settings_power,
              size: 22,
            ),
            title: Text('Deconnexion', style: TextStyle(fontSize: 22)),
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
