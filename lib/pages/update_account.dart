import 'package:flutter/material.dart';
import 'package:maney/models/account.dart';
import 'package:maney/models/info_customer.dart';
import 'package:maney/models/DbManager.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;

class UpdateAccount extends StatefulWidget {
  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

enum OperationType { Crediter, Debiter }

class _UpdateAccountState extends State<UpdateAccount> {
  final _formOfUpdateAccount = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _amountController = TextEditingController();
  // InfoCustomerUserAccount data;
  bool _isDisabledButton = true;
  DbUserManager dbusermanager = DbUserManager();
  Map userData;
  InfoCustomerUserAccount _data;
  Account account = Account(
      accountId: null,
      userId: null,
      ownerAccount: null,
      balance: 0,
      operationId: null,
      accountCreatedAt: null);

  OperationType _character = OperationType.Debiter;

  @override
  Widget build(BuildContext context) {
    Map alldata = ModalRoute.of(context).settings.arguments;
    _data = alldata["customerInfo"];
    userData = alldata["userData"];

    print("data id customer ${_data.idOwner}");
    _phoneNumberController.text = _data.phoneNumberOwner;
    _amountController.text = _data.balance.toString();

    if (int.parse(_amountController.text) == _data.balance) {
      setState(() {
        _isDisabledButton = false;

        print("premiere verification : ${_data.amount}");
      });
    }
    var mediaQueryData = MediaQuery.of(context);
    final cardWidth = mediaQueryData.size.width;
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent[400],
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home',
                  arguments: userData);
            }),
        actions: <Widget>[],
        centerTitle: true,
        title: Text('Mise à jour de compte',
            ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            width: cardWidth * 0.97,
            child: Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Container(                    
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    color: Colors.deepPurpleAccent[400],                                     
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Text('Mise à jour du compte', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: Form(
                      key: _formOfUpdateAccount,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: TextFormField(
                              initialValue: _phoneNumberController.text,
                              readOnly: true,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              decoration: InputDecoration(
                                  // border: InputBorder.none,
                                  hintText: 'Numéro',
                                  // labelText: _phoneNumberController.text,
                                  // enabled: false,
                                  hintStyle: TextStyle(
                                      color: Colors.greenAccent, fontSize: 18)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: TextFormField(
                              onChanged: (value) {
                                _data.amount = int.parse(value);
                                if (value.isEmpty) {
                                  print(
                                      "Le montant doit être inférieur au solde : ${_data.balance}");
                                  setState(() {
                                    _isDisabledButton = true;
                                    _amountController.text = value;
                                    print(_amountController.text);
                                  });
                                } else {
                                  print('****** Bien ******');
                                  setState(() {
                                    _isDisabledButton = false;
                                    _amountController.text = value;
                                    _data.amount = int.parse(value);
                                    print("donnee : ${_amountController.text}");
                                  });
                                }
                              },
                              initialValue: _amountController.text,
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : "Champ de saisie obligatoire",
                              maxLength: (_character.index == 1)
                                  ? _data.balance.toString().length
                                  : 4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  // border: InputBorder ,
                                  hintText: 'Montant',
                                  fillColor: Colors.redAccent,
                                  hintStyle: TextStyle(
                                      // backgroundColor: Colors.redAccent,
                                      color: Colors.grey[400],
                                      fontSize: 18)),
                            ),
                          ),
                          RadioListTile<OperationType>(
                            title: const Text('Créditer'),
                            value: OperationType.Crediter,
                            groupValue: _character,
                            onChanged: (OperationType value) {
                              setState(() {
                                _character = value;
                                print(_character.index);
                              });
                            },
                          ),
                          RadioListTile<OperationType>(
                            title: const Text('Débiter'),
                            value: OperationType.Debiter,
                            groupValue: _character,
                            onChanged: (OperationType value) {
                              setState(() {
                                _character = value;
                                print(_character.index);
                              });
                            },
                          ),
                          Container(
                            width: cardWidth,
                            child: RaisedButton(
                              disabledElevation: 10.0,
                              disabledColor: Color.fromARGB(0, 0, 200, 0),
                              padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                              onPressed: _isDisabledButton
                                  ? null
                                  : () {
                                      _updateAccount();
                                    },
                              child: Text(
                                "Enregistrer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateAccount() {
    //recupérer les valeur des champs du formulaire
    if (_formOfUpdateAccount.currentState.validate()) {
      // account.balance;
      account.balance = _data.balance;

      if (_data.amount == null)
        _data.amount = int.parse(_amountController.text);

      // account.balance = _data.balance + _data.amount;
      account.ownerAccount = _data.idOwner;
      print("Votre solde est de : ${account.balance}");
      print("L'identifiant de l'utilisateur ${_data.amount}");
      print(" le champ du montant contient: ${_amountController.text}");
      print(_character.index);
      if (_character.index == 0) {
        // crediter le compte
        print("Le champs de saisie' ${_data.amount}");

        account.balance = account.balance + _data.amount;
        print("************** Créditer un compte **************\n");
        print("Votre Nouveau solde est de : ${account.balance}");
        dbusermanager.updateAccountCustomer(account).then((value) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              elevation: 10,
              content: Text(
                "Compte crédité avec succès",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.greenAccent,
            ),
          );
        });
      } else {
        // débiter le compte
        print("************** Debiter un compte **************\n");
        print("Votre solde actuel est : ${account.balance}");
        print("Le champs de saisie : ${_data.amount}");
        account.balance = account.balance - _data.amount;
        print("Votre Nouveau solde est de : ${account.balance}");

        dbusermanager.updateAccountCustomer(account).then((value) {
          print(value);
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              elevation: 10,
              content: Text(
                "Compte débité avec succès",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.greenAccent,
            ),
          );
        });
      }
    }
  }
}
