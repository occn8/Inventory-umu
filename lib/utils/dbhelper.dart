import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/products.dart';
import '../models/users.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;
  static Database _database;

  String productTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
//user table
  String userTable = 'user_table';
  String usrId = 'id';
  String usrName = 'name';
  String usrPassword = 'password';

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      // 'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate Text)'
      'CREATE TABLE $userTable($usrId INTEGER PRIMARY KEY AUTOINCREMENT, $usrName TEXT,$usrPassword TEXT)',
    );
  }

  //fetch operation
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(productTable, orderBy: '$colPriority ASC');
    return result;
  }

  //insert operation
  Future<int> insertNote(Products note) async {
    Database db = await this.database;
    var result = await db.insert(productTable, note.toMap());
    return result;
  }

  //update operation
  Future<int> updateNote(Products note) async {
    Database db = await this.database;
    var result = await db.update(productTable, note.toMap(),
        where: '$colId =?', whereArgs: [note.id]);
    return result;
  }

  //delete operation
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $productTable WHERE $colId = $id');
    return result;
  }

  //get no of items in db
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $productTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //get map list[list<map>] | convert it to notelist
  Future<List<Products>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Products> noteList = List<Products>();
    for (int i = 0; i < count; i++) {
      noteList.add(Products.fromMapOject(noteMapList[i]));
    }
    return noteList;
  }


  //user helper functions.......................................................................................
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(userTable, orderBy: '$usrName ');
    return result;
  }

  //insert operation
  Future<int> insertUser(Users users) async {
    Database db = await this.database;
    var result = await db.insert(userTable, users.toMap());
    return result;
  }

  //update operation
  Future<int> updateUser(Users users) async {
    Database db = await this.database;
    var result = await db.update(userTable, users.toMap(),
        where: '$usrId =?', whereArgs: [users.id]);
    return result;
  }

  //delete operation
  Future<int> deleteUser(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $userTable WHERE $usrId = $id');
    return result;
  }

  Future<int> getUserCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $userTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Users>> getUserList() async {
    var userMapList = await getUserMapList();
    int count = userMapList.length;
    List<Users> userList = List<Users>();
    for (int i = 0; i < count; i++) {
      userList.add(Users.fromMapOject(userMapList[i]));
    }
    return userList;
  }
}
