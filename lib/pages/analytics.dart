import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/pages/widget.dart';
import 'package:maney/models/DbManager.dart';
import 'package:maney/models/info_analytics.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  DbUserManager dbusermanager = DbUserManager();
  InfoAnalytics infoAnalytics = InfoAnalytics();

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    print('analytics : data username : ${data["username"]}');
    // var mediaQueryData = MediaQuery.of(context);
    // final cardWidth = mediaQueryData.size.width;

    return Scaffold(
      // backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text('Analyse des données'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 140,
                      margin: EdgeInsets.all(1),
                      // color: Colors.amber,
                      child: FutureBuilder(
                          future: dbusermanager.countCustomer(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              infoAnalytics.effCust = snapshot.data;
                              return Card(
                                  elevation: 10,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${infoAnalytics.effCust}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Clients enregistrés',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 140,
                      margin: EdgeInsets.all(1),
                      // color: Colors.amber,
                      child: FutureBuilder(
                          future: dbusermanager.totalBalance(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              infoAnalytics.allCredit = snapshot.data;
                              return Card(
                                  elevation: 10,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${infoAnalytics.allCredit} cfa',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Total credit client',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 140,
                      margin: EdgeInsets.all(1),
                      // color: Colors.amber,
                      child: FutureBuilder(
                          future: dbusermanager.percentReturnedCredit(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              infoAnalytics.percentOfReturnedCredit = snapshot.data;
                              final resultTemp = (infoAnalytics.effCust != 0) ? ((infoAnalytics.percentOfReturnedCredit.toDouble()/infoAnalytics.effCust.toDouble())*100) : 1.0;
                              final result = (resultTemp != 1 ) ? resultTemp.toStringAsFixed(2) : 0;
                              return Card(
                                  elevation: 10,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '$result%',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Crédit retiré totalement',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: DrawerWidget(
          userData: data["username"],
        ));
  }
}
