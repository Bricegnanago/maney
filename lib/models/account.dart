import 'package:flutter/material.dart';

// la classe utilisateur avec toutes ses propriété
class Account {
  int accountId; // identifiant du compte
  int userId; // l'utilisateur ayant autorisé l'enregistrement du compte
  int ownerAccount; // Le client propriétaire du compte 
  int operationId; //le type d'operation 
  int balance; // Le solde actuel du compte
  String accountCreatedAt; // La date de création du compte
  String accountLastUpdate; // La derniere mise à jour
 
  
  Account(
      { 
      @required this.accountId,
      @required this.userId,
      @required this.ownerAccount,
      @required this.operationId,
      @required this.balance,
      @required this.accountCreatedAt,
      this.accountLastUpdate,
      });

  Map<String, dynamic> toMap() {
    // accountCreatedAt = 'strftime("%d-%m-%Y %H:%M:%S", datetime("now"))';
    return {
      "accountId": accountId,
      "userId": userId,
      "ownerAccount": ownerAccount,
      "operationId": operationId,
      "balance": balance,
      "accountCreatedAt": accountCreatedAt,
      "accountLastUpdate": accountLastUpdate,      
    };
  }
}
