import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maney/models/DbManager.dart';
import 'package:maney/models/customer.dart';
import 'package:maney/models/account.dart';
import 'package:maney/models/info_customer.dart';
import 'package:maney/pages/widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formToSaveClient = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Customer customer = Customer(fullName: "", phoneNumber: "");
  Account account =
      Account(accountId: null, userId: null, ownerAccount: null, balance: null);
  List<InfoCustomerUserAccount> infos;
  DbUserManager dbusermanager = DbUserManager();
  List<Customer> customers;
  bool isValidate = false;
  String message;
  var maskTextInputFormatter =
      MaskTextInputFormatter(mask: "########", filter: {"#": RegExp(r'[0-9]')});

  void changeMessage() {
    setState(() {
      isValidate = !isValidate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Accueil'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
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
          future: dbusermanager.getInfoCustomerUserAccount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //donnee bien recu
              infos = snapshot.data;
              print("*************** info lenght : ${infos.length}");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: (infos.length == null) ? 0 : infos.length,
                  itemBuilder: (BuildContext context, int index) {
                    InfoCustomerUserAccount info = infos[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.all(1),
                          elevation: 1,
                          child: ListTile(
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            onTap: () {
                              print("${info.fullNameOwner}");
                            },
                            leading: Icon(Icons.person),
                            title: Text(
                              '${info.fullNameOwner}',
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text('${info.phoneNumberOwner}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey)),
                            trailing: Container(
                              width: 50,
                              height: 30,                              
                              child: Center(
                                child: Text('${info.balance}',
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
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          onPressed: () {
            // afficher une modal pour un nouveau client
            //On enregistre un nouvel utilisateur
            showDialo();
          },
          elevation: 30,
          backgroundColor: Colors.deepPurple[400],
        ),
        drawer: DrawerWidget(
          userData: data["username"],
        ));
  }

  void showDialo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formToSaveClient,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: _fullNameController,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nom et Prénom',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 18)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              inputFormatters: [maskTextInputFormatter],
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              decoration: InputDecoration(
                                  // labelText: "+(225) 89-29-12-12",
                                  border: InputBorder.none,
                                  hintText: "89291212",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 18)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextFormField(
                              controller: _amountController,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              maxLength: 5,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Montant initial',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 18)),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 320.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _fullNameController.clear();
                                      _phoneNumberController.clear();
                                      _amountController.clear();
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
                                      submitCustomer(context);                                   
                                      print("validate : $isValidate");
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void submitCustomer(BuildContext context) {
    //vérifier si le formulaire à été soumi
    if (_formToSaveClient.currentState.validate()) {
      customer.fullName = _fullNameController.text;
      customer.phoneNumber = _phoneNumberController.text;
      account.balance = double.parse(_amountController.text);
      //Inserer dans la base de donnée et actualiser la liste de client
      dbusermanager.isCustomerExist(customer).then((value) {
        if (value) {
          dbusermanager.insertCustomer(customer).then((customerId) {
            print('customerid : $customerId');
            account.ownerAccount = customerId;
            if (!customerId.isNaN) {
              dbusermanager
                  .initAccountCustomer(account)
                  .then((accountId) => print("accountId $accountId"))
                  .catchError((onError) => print("Erreur : $onError"));
              setState(() {
                isValidate = true;
                message = "Nouveau client enregistré avec succès";
              });
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                    elevation: 10,
                    content: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.green),
              );
            } else {
              setState(() {
                isValidate = false;
                message = "Le client a déjà été enregistré";
              });
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  elevation: 10,
                  content: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          });
        } else {
          setState(() {
            isValidate = false;
            message = "Le client a déjà été enregistré";
          });
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              elevation: 10,
              content: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      });
      _fullNameController.clear();
      _phoneNumberController.clear();
      _amountController.clear();
      Navigator.pop(context);
    }
  }
}

// class CustomerItemSearch extends SearchDelegate<Customer> {
//   String _results;
//   void changeResult(context, String string) {
//     _results = string;
//     showResults(context);
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = "";
//         },
//         icon: Icon(Icons.clear),
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     query = _results;
//     return Center(child: Text(query));
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     customers = query.isEmpty
//         ? dbuser()
//         : loadFoodItem()
//             .where((food) =>
//                 food.title.toUpperCase().startsWith(query.toUpperCase()))
//             .toList();
//     return (myList.isEmpty)
//         ? Center(
//             child: Text("Aucun article trouvé ?"),
//           )
//         : ListView.builder(
//             itemCount: myList.length,
//             itemBuilder: (context, index) {
//               FoodItem foodItem = myList[index];
//               return ListTile(
//                 onTap: () {
//                   changeResult(context, foodItem.title);
//                 },
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(foodItem.title),
//                     Text(foodItem.category),
//                     if (index != myList.length - 1) Divider(),
//                   ],
//                 ),
//               );
//             });
//   }

//   // Soumettre le client
//   // 1 - vérifier s'il existe déja dans la base
//   // 2 l'inserer sinon si oui retourner un message d'erreur

// }
