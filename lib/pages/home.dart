import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent[400],
      ),
      body: Center(
        child: Text(
          'La liste des clients en détail',
          style: TextStyle(
          fontSize: 30
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add, color: Colors.white,),
        onPressed: (){
          // afficher une modal pour un nouveau client

        },
        elevation: 30,
        backgroundColor: Colors.deepPurple[400],
        
      ),
      drawer: DrawerWidget(userData: data["username"])
    );
  }
}