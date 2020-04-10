import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/products.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;
  static Database _database; 

  String productTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

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
        'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate Text)');
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
}
