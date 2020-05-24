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
        /* 
            Creation de la table des niveaux d'utilisateur : il y a plusieurs niveaux d'administration
            USER - ADMIN - SUPERUSER
          */
        final String userLevel = 'CREATE TABLE userLevel('
            'level_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT, libelle text)';
        await db.execute(userLevel);
        final String insertUserLevel = 'INSERT INTO userLevel VALUES'
            '(null, "USER", "Utilisateur de niveau 1"),'
            '(null, "ADMIN", "Utilisateur de niveau 2"),'
            '(null, "SUPERUSER", "Utilisateur de niveau 3")';
        await db.execute(insertUserLevel);

        /* 
            Creation de la table uitilisateur
          */
        final String reqUser = 'CREATE TABLE user('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'username TEXT NOT NULL,'
            'password TEXT NOT NULL,'
            'status INTEGER DEFAULT 1,'
            'level INTEGER NOT NULL DEFAULT 2'
            'createdAt TIMESTAMP,'
            'FOREIGN KEY(level) REFERENCES userLevel(level_id)';

        await db.execute(reqUser);
        final reqTonIsertOneUser = 'INSERT INTO user VALUES('
            'null, "gnanagobrice@gmail.com", '
            '"%mamson%", 1, 2,'
            'strftime("%d-%m-%Y %H:%M:%S", datetime("now")))';
        await db.execute(reqTonIsertOneUser);

        // Creation de la table operation : elle define le type de l'opération
        final String reqOperation = 'CREATE TABLE operation('
            'operation_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'description TEXT,'
            ')';
        await db.execute(reqOperation);

        // creation du compte client
        final String reqCreateCustomerAccount = 'CREATE TABLE account('
            'account_id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'user_id intEGER, owner_account integer,'
            'balance REAL, createdAt timestamp,lastUpdate timestamp,'
            'FOREIGN KEY(user_id) REFERENCES user(user_id),'
            'FOREIGN KEY(owner_account) REFERENCES customer(customer_id))';

        await db.execute(reqCreateCustomerAccount);
        //INSERTION DE DIFFERENTES OPERATION
        final String reqInsertIntoOperation = 'INSERT INTO operation VALUES'
            '(null, "CREDIT", "Crediter le compte client"),'
            '(null, "DEBIT", "Debiter le compte client")';

        await db.execute(reqInsertIntoOperation);
        // Creation de la table des historiques
        final String reqStory = 'CREATE TABLE story('
            'story_id integer PRIMARY KEY AUTOINCREMENT not null,'
            'customer_id integer,'
            'user_id integer,'
            'amount real,'
            'operation_id integer,'
            'dateOfCredit TIMESTAMP,'
            'cancelCredit timestamp NULL,'
            'FOREIGN KEY(operation_id) REFERENCES operation(operation_id),'
            'FOREIGN KEY(customer_id) REFERENCES customer(customer_id)'
            ')';
        await db.execute(reqStory);
      });
      // initialisation de la base de donnée
      // _database
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
        if (us["password"] == user.password) return true;
      }
    }
    return false;
  }
}
