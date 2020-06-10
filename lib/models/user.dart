import 'package:flutter/material.dart';

// la classe utilisateur avec toutes ses propriété
class User {
  int userId;
  String username;
  String password;
  String createdAt;
  String status;
  User(
      {@required this.username,
      @required this.password,
      this.userId,
      this.createdAt,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "password": password,
      "createdAt": createdAt,
      "status": status,
    };
  }
}
