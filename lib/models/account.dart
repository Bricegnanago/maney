import 'package:flutter/material.dart';

// la classe utilisateur avec toutes ses propriété
class Account {
  int accountId; // identifiant du compte
  int userId; // l'utilisateur ayant autorisé l'enregistrement du compte
  int ownerAccount; // Le client propriétaire du compte 
  double balance; // Le solde actuel du compte
  String accountCreatedAt; // La date de création du compte
  String accountLastUpdate; // La derniere mise à jour
  
  Account(
      { 
      @required this.accountId,
      @required this.userId,
      @required this.ownerAccount,
      @required this.balance,
      this.accountCreatedAt,
      this.accountLastUpdate});

  Map<String, dynamic> toMap() {
    return {
      "accountId": accountId,
      "userId": userId,
      "ownerAccount": ownerAccount,
      "balance": balance,
      "accountCreatedAt": accountCreatedAt,
      "accountLastUpdate": accountLastUpdate,
    };
  }
}
