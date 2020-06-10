import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:maney/models/user.dart';
import 'package:maney/models/customer.dart';
import 'package:maney/models/account.dart';
import 'package:maney/models/info_customer.dart';

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
            'levelId INTEGER PRIMARY KEY AUTOINCREMENT,'
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
            'userId INTEGER PRIMARY KEY AUTOINCREMENT,'
            'username TEXT NOT NULL,'
            'password TEXT NOT NULL,'
            'status INTEGER DEFAULT 1,'
            'level INTEGER DEFAULT 2,'
            'createdAt TIMESTAMP,'
            'FOREIGN KEY(level) REFERENCES userLevel(levelId)'
            ')';
        await db.execute(reqUser);
        final reqTonIsertOneUser = 'INSERT INTO user VALUES('
            'null, "gnanagobrice@gmail.com", '
            '"%mamson%", 1, 3,'
            'strftime("%d-%m-%Y %H:%M:%S", datetime("now")))';
        await db.execute(reqTonIsertOneUser);

        final String reqCustomer =
            'CREATE TABLE customer(customerId INTEGER PRIMARY KEY AUTOINCREMENT,'
            'fullName TEXT, emailAddress TEXT DEFAULT NULL, phoneNumber TEXT , customerCreatedAt timestamp)';
        await db.execute(reqCustomer);

        // Creation de la table operation : elle define le type de l'opération
        final String reqOperation = 'CREATE TABLE operation('
            'operationId INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'description TEXT'
            ')';
        await db.execute(reqOperation);

        // creation du compte customer
        final String reqCreateCustomerAccount = 'CREATE TABLE account('
            'accountId INTEGER PRIMARY KEY AUTOINCREMENT,'
            'userId INTEGER, ownerAccount integer,'
            'balance REAL, accountCreatedAt timestamp,accountLastUpdate timestamp,'
            'FOREIGN KEY(userId) REFERENCES user(userId),'
            'FOREIGN KEY(ownerAccount) REFERENCES customer(customerId))';

        await db.execute(reqCreateCustomerAccount);
        //INSERTION DE DIFFERENTES OPERATION
        final String reqInsertIntoOperation = 'INSERT INTO operation VALUES'
            '(null, "CREDIT", "Crediter le compte client"),'
            '(null, "DEBIT", "Debiter le compte client")';

        await db.execute(reqInsertIntoOperation);
        // Creation de la table des historiques
        final String reqStory = 'CREATE TABLE story('
            'storyId integer PRIMARY KEY AUTOINCREMENT not null,'
            'customerId integer,'
            'userId integer,'
            'amount real,'
            'operationId integer,'
            'dateOfCredit TIMESTAMP,'
            'cancelCredit timestamp NULL,'
            'FOREIGN KEY(operationId) REFERENCES operation(operationId),'
            'FOREIGN KEY(customerId) REFERENCES customer(customerId)'
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
    openDb();
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
              userId: maps[index]["userId"],
              username: maps[index]["username"],
              password: maps[index]["password"],
            ));
  }

  //Met a jour un utilisateur de la base de données
  Future<int> updateUser(User user) async {
    await openDb();
    return await _database.update("user", user.toMap(),
        where: "userId = ?", whereArgs: [user.userId]);
  }

  //Supprime un utlisateur de la liste
  Future<int> deleteUser(int userId) async {
    await openDb();
    return await _database
        .delete("user", where: "userId = ? ", whereArgs: [userId]);
  }

// Vérifie si l'utilisateur est loggé
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

  Future<bool> isCustomerExist(Customer customer) async {
    openDb();
    List<Map<String, dynamic>> users = await _database.query("customer",
        where: 'fullName = ? OR phoneNumber = ?',
        whereArgs: [customer.fullName.toUpperCase(), customer.phoneNumber]);

    if (users.length == 1) {
      return false; // Le clietnt existe déjà - Enregistrement interdit
    } else {
      return true; // Enregistrement autorisé
    }
  }

  Future<int> insertCustomer(Customer customer) async {
    await openDb();
    // bool flag = await isCustomerExist(customer);
    return await _database.insert('customer', customer.toMap());
  }

  Future<bool> isPhoneNumberOfCustomerExist(Customer customer) async {
    // String sql = "SELECT COUT(*) FROM user";
    //obtenir la liste de tous les utilisateurs
    await openDb();
    List<Map<String, dynamic>> users = await _database.query("customer",
        where: 'phoneNumber= ?', whereArgs: [customer.phoneNumber]);
    if (users.length == 1) {
      return true; //Enregistrement interdit
    } else {
      return false; //Enregistrement autorisé
    }
    // return 0 : return 1;
  }

  Future<bool> isFullNameOfCustomerExist(Customer customer) async {
    // String sql = "SELECT COUT(*) FROM user";
    //obtenir la liste de tous les utilisateurs
    await openDb();
    List<Map<String, dynamic>> users = await _database.query("customer",
        where: 'fullName= ?', whereArgs: [customer.fullName]);
    if (users.length == 1) {
      return true; //Enregistrement interdit
    } else {
      return false; //Enregistrement autorisé
    }
    // return 0 : return 1;
  }

  // Toute la liste des utilisateurs
  Future<List<Customer>> getListCustomer() async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query("customer", orderBy: " customerId DESC");
    return List.generate(
        maps.length,
        (index) => Customer(
              customerId: maps[index]["customerId"],
              fullName: maps[index]["fullName"],
              phoneNumber: maps[index]["phoneNumber"],
            ));
  }

  // Supprimer un client
  Future<int> deleteCustomer(int id) async {
    await openDb();
    return await _database
        .delete("customer", where: "customerId = ? ", whereArgs: [id]);
  }

/* MISE A JOUR DU COMPTE UTILISATEUR */
// On renseigne ici le montant saisie par l'utilisateur lors de l'enregistrement du client
// Ou

// 'accountId INTEGER PRIMARY KEY AUTOINCREMENT,'
//             'user_id intEGER, ownerAccount integer,'
//             'balance REAL, createdAt timestamp,lastUpdate timestamp,'

  Future<int> initAccountCustomer(Account account) async {
    await openDb();
    return await _database.insert('account', account.toMap());
  }

  Future<int> getIdOfUser(String username) async {
    await openDb();
    final List<Map<String, dynamic>> result = await _database
        .rawQuery("SELECT userId FROM user WHERE username = ?", [username]);

    return result[0]['userId'];
  }

  // Future<Account> getListOfAccount(int id) async {
  //   await openDb();

  //   List<Account> accountInfo = await _database.query("account", where: "accountId = ?", whereArgs: [id]);
  //   return  accountInfo[0];
  // }

  Future<List<InfoCustomerUserAccount>> getInfoCustomerUserAccount() async {
    //jointure
    await openDb();
    const sql = 'SELECT fullName as fullNameOwner, '
        'phoneNumber as phoneNumberOwner, '
        'emailAddress as emailAddressOwner, '
        'customerCreatedAt, '
        'balance, '
        'accountCreatedAt, '
        'accountLastUpdate '
        'FROM customer INNER JOIN account ON customer.customerId = account.ownerAccount order by customer.customerId desc'

        // 'WHERE customer.customerId = account.ownerAccount '
        // 'AND user.userId = account.userId '
        ;
    List<Map<String, dynamic>> infos = await _database.rawQuery(sql);

    return List.generate(
        infos.length,
        (index) => InfoCustomerUserAccount(
              fullNameOwner: infos[index]["fullNameOwner"],
              phoneNumberOwner: infos[index]["phoneNumberOwner"],
              emailAddressOwner: infos[index]["emailAddressOwner"],
              customerCreatedAt: infos[index]["customerCreatedAt"],
              balance: infos[index]["balance"],
              accountCreatedAt: infos[index]["accountCreatedAt"],
              accountLastUpdate: infos[index]["accountLastUpdate"],
            ));
  }
}
