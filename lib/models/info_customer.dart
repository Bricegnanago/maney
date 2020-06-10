import 'package:flutter/cupertino.dart';

class InfoCustomerUserAccount {
  String fullNameOwner;
  String phoneNumberOwner;
  String emailAddressOwner;
  String customerCreatedAt;  
  double balance; // Le solde actuel du compte
  String accountCreatedAt; // La date de création du compte
  String accountLastUpdate;

  InfoCustomerUserAccount({
    @required this.fullNameOwner,
    @required this.phoneNumberOwner,
    this.emailAddressOwner,
    this.customerCreatedAt,  
    this.balance,
    this.accountCreatedAt,
    this.accountLastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      "fullNameOwner": fullNameOwner,
      "phoneNumberOwner": phoneNumberOwner.toUpperCase(),
      "emailAddressOwner": emailAddressOwner.toUpperCase(),
      "customerCreatedAt": customerCreatedAt,
      "balance" : balance,
      "accountCreatedAt" : accountCreatedAt,
      "accountLastUpdate": accountLastUpdate,
    };
  }




}