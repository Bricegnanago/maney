import 'package:flutter/material.dart';

// la classe utilisateur avec toutes ses propriété
class User {
  int userId;
  String username;
  String password;
  String createdAt;
  int status; // activé ou désactivé
  int level; // administrateur utilsateur ou superutiisateur
  String lastUpdate;
  User(
      {@required this.username,
      @required this.password,
      this.userId,
      this.createdAt,
      this.status,
      this.level,
      this.lastUpdate,
      });

  Map<String, dynamic> toMap() {
    // createdAt = 'strftime("%d-%m-%Y %H:%M:%S", datetime("now"))';
    return {
      "userId": userId,
      "username": username,
      "password": password,
      "createdAt": createdAt,
      "status": status,
      "level" : level,
      "lastUpdate" : lastUpdate,
    };
  }
}
