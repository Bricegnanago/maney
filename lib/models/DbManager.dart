import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:maney/models/user.dart';

main(List<String> args) {
  print("Bonjour");
}
class DbUserManager {
  Database _database;
  DbUserManager();
  Future openDb() async {
    if (_database == null) {
      //creation de la base de données
      _database = await openDatabase(join(await getDatabasesPath(), "user.db"),
          version: 1, onCreate: (Database db, int version) async {
        final String req = 'CREATE TABLE user('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'username TEXT NOT NULL,'
            'password TEXT NOT NULL,'
            'status INTEGER DEFAULT 1,'
            'createdAt TIMESTAMP)';
        await db.execute(req);
        // String req2 = 'INSERT INto user1 values'
        // '(null, "bricegnanago@gmail.com", '
        // '"12323",1,'
        // 'strftime("%d-%m-%Y %H:%M:%S", datetime("now")))';        
      });
    }
  }

/*
Verifie si le client existe dans la base de données
Cette fonction returne un entier
*/
  Future<bool> isUserExist(User user) async {
    // String sql = "SELECT COUT(*) FROM user";
    //obtenir la liste de tous les utilisateurs
   
    List<Map<String, dynamic>> users = await _database
        .query("user", where: 'username = ?', whereArgs: [user.username]);
    if (users.length == 1) {
      return true; //Enregistrement interdit
    } else {
      return false; //Enregistrement autorisé
    }
    // return 0 : return 1;
  }

/*
insert un client dans la base e données
*/
  Future<int> insertUser(User user) async {
    await openDb();
    bool flag = await isUserExist(user);
    if (flag)
      return -1;
    else
      return await _database.insert('user', user.toMap());
  }

  // Recupère la liste de tout les utilisateurs
  Future<List<User>> getListuser() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query("user");
    return List.generate(
        maps.length,
        (index) => User(
              id: maps[index]["id"],
              username: maps[index]["username"],
              password: maps[index]["password"],
            ));
  }

  //Met a jour un utilisateur de la base de données
  Future<int> updateUser(User user) async {
    await openDb();
    return await _database
        .update("user", user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  //Supprime un utlisateur de la liste
  Future<int> deleteUser(int id) async {
    await openDb();
    return await _database.delete("user", where: "id = ? ", whereArgs: [id]);
  }

  Future<bool> isLogged(User user) async {
    // String sql = "SELECT COUT(*) FROM user";
    //obtenir la liste de tous les utilisateurs
    await openDb();
    List<Map<String, dynamic>> allUsers = await _database.query("user");

    for (Map us in allUsers) {
      if (us["username"] == user.username) {
        if(us["password"] == user.password) return true ;      
      }      
    }
    return false;
  }

  
}
