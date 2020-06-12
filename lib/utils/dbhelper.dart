import 'package:curve4/models/report_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/products_model.dart';
import '../models/users_model.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;
  static Database _database;

  String productTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
  String colBarcode = 'barcode';

//user table
  String userTable = 'user_table';
  String usrId = 'id';
  String usrName = 'name';
  String usrPassword = 'password';

//report table
  String rptTable = 'report_table';
  String rptId = 'id';
  String rptDate = 'date';
  String rptWriter = 'writer';
  String rptTxt = 'reportTxt';

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
    String path = directory.path + 'inventory.db';

    var invtDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return invtDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      // 'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate Text)'
      'CREATE TABLE $userTable($usrId INTEGER PRIMARY KEY AUTOINCREMENT, $usrName TEXT,$usrPassword TEXT)',
    );
    await db.execute(
      'CREATE TABLE $rptTable($rptId INTEGER PRIMARY KEY AUTOINCREMENT, $rptWriter TEXT,$rptTxt TEXT, $rptDate Text)',
    );
    await db.execute(
        'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT, $colPriority INTEGER, $colDate Text, $colBarcode Text)');
  }

  //fetch operation
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(productTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(ProductsModel note) async {
    Database db = await this.database;
    var result = await db.insert(productTable, note.toMap());
    return result;
  }

  Future<int> updateNote(ProductsModel note) async {
    Database db = await this.database;
    var result = await db.update(productTable, note.toMap(),
        where: '$colId =?', whereArgs: [note.id]);
    return result;
  }

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
  Future<List<ProductsModel>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<ProductsModel> noteList = List<ProductsModel>();
    for (int i = 0; i < count; i++) {
      noteList.add(ProductsModel.fromMapOject(noteMapList[i]));
    }
    return noteList;
  }

  //user helper functions.......................................................................................
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query(userTable, orderBy: '$usrName ');
    return result;
  }

  Future<int> insertUser(UsersModel users) async {
    Database db = await this.database;
    var result = await db.insert(userTable, users.toMap());
    return result;
  }

  Future<int> updateUser(UsersModel users) async {
    Database db = await this.database;
    var result = await db.update(userTable, users.toMap(),
        where: '$usrId =?', whereArgs: [users.id]);
    return result;
  }

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

  Future<List<UsersModel>> getUserList() async {
    var userMapList = await getUserMapList();
    int count = userMapList.length;
    List<UsersModel> userList = List<UsersModel>();
    for (int i = 0; i < count; i++) {
      userList.add(UsersModel.fromMapOject(userMapList[i]));
    }
    return userList;
  }

  //report helper functions.......................................................................................
  Future<List<Map<String, dynamic>>> getReportMapList() async {
    Database db = await this.database;
    var result = await db.query(rptTable, orderBy: '$rptWriter ');
    return result;
  }

  Future<int> insertReport(ReportModel report) async {
    Database db = await this.database;
    var result = await db.insert(userTable, report.toMap());
    return result;
  }

  Future<int> updateReport(ReportModel report) async {
    Database db = await this.database;
    var result = await db.update(rptTable, report.toMap(),
        where: '$rptId =?', whereArgs: [report.id]);
    return result;
  }

  Future<int> deleteReport(int id) async {
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $rptTable WHERE $rptId = $id');
    return result;
  }

  Future<int> getReportCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $rptTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<ReportModel>> getReportList() async {
    var reportMapList = await getReportMapList();
    int count = reportMapList.length;
    List<ReportModel> reportList = List<ReportModel>();
    for (int i = 0; i < count; i++) {
      reportList.add(ReportModel.fromMapOject(reportMapList[i]));
    }
    return reportList;
  }
}
