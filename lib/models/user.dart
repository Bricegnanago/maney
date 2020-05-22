import 'package:flutter/material.dart';

// la classe utilisateur avec toutes ses propriété
class User {
  int id;
  String username;
  String password;
  String createdAt;
  String status;
  User(
      {@required this.username,
      @required this.password,
      this.id,
      this.createdAt,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "createdAt": createdAt,
      "status": status,
    };
  }
}
