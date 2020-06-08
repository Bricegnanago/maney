import 'package:flutter/material.dart';

//CREATE TABLE customers(customer_id integer primary
//key autoincrement not NULL, fullname Text, email_address Text, createdAt timestamp)
// la classe utilisateur avec toutes ses propriété
class Customer {
  int customerId;
  String fullName;
  String phoneNumber;
  String emailAddress;
  String createdAt;
  Customer({
    this.customerId,
    @required this.fullName,
    @required this.phoneNumber,
    this.emailAddress,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "emailAddress": emailAddress,
      "createdAt": createdAt,
    };
  }
}
