// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';


//TODO

/*
  installation package : sqflite (done), path (done), spinner
*/

// class DbManager {
//   Database _database;
//   Future openDb() async {
//     if (_database == null) {
//       //creation de la base de données
//       _database = await openDatabase(
//           join(await getDatabasesPath(), "maney.db"),
//           version: 1, onCreate: (Database db, int version) async {
//         await db.execute(
//         "CREATE TABLE status(statutId integer PRIMARY KEY AUTOINCREMENT, statusName TEXT)");
//         await db.execute(
//             "create table user (id intEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL, createdAt TIMESTAMP, statusId INTERGER, flag INTEGER DEFAULT 1, lastModif DATETIME NULL, FOREIGN KEY (statusId) REFERENCES status(statusId) )");
//         await db.execute(
//         "CREATE TABLE client(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, )");
//       });
      
//     }
//   }

// Future<bool> isStudentExist(Student student) async {
//     // String sql = "SELECT COUT(*) FROM student";
//     List<Map<String, dynamic>> students = await _database.query("student", where: 'name = ?', whereArgs: [student.name]);
//     if(students.length == 1){
//       return true; //Enregistrement interdit
//     } else{
//       return false;//Enregistrement autorisé
//     }
//       // return 0 : return 1;
//   }

//   Future<int> insertStudent(Student student) async {
//     await openDb();
//     bool flag = await isStudentExist(student);
//       if(flag)
//         return -1;
//       else
//         return await _database.insert('student', student.toMap());
//   }

//   Future<List<Student>> getListStudent() async {
//     await openDb();
//     final List<Map<String, dynamic>> maps = await _database.query("student");
//     return List.generate(
//         maps.length,
//         (index) => Student(
//               id: maps[index]["id"],
//               name: maps[index]["name"],
//               course: maps[index]["course"],
//             ));
//   }

//   Future<int> updateStudent(Student student) async {
//     await openDb();
//     return await _database.update("student", student.toMap(),
//         where: "id = ?", whereArgs: [student.id]);
//   }

//   Future<int> deleteStudent(int id) async {
//     await openDb();
//     return await _database
//         .delete("student", where: "id = ? ", whereArgs: [id]);
//   }

// }

// class Student {
//   int id;
//   String name;
//   String course;
//   Student({@required this.name, @required this.course, this.id});

//   Map<String, dynamic> toMap() {
//     return {
//       "name": name,
//       "course": course,
//     };
//   }
// }
