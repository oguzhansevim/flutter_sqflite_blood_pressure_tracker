import 'dart:async';

import '../constants/application_constants.dart';

import '../model/blood_pressure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  initDb() async {
    // This function get the path for creating Database by OS type
    var dbFolder = await getDatabasesPath();

    // We combine the path and database name on path variable
    String path = join(dbFolder, ApplicationConstants.DATABASE);

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  // Creating table
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(ApplicationConstants.DATABASE_CREATE_QUERY);
  }

  // Getting datas from the table
  Future<List<BloodPressure>> get() async {
    var dbClient = await database;
    var result = await dbClient.query(ApplicationConstants.DATABASE_TABLE);

    return result.map((e) => BloodPressure.fromMap(e)).toList();
  }

  // Inserting data to table
  Future<int> insert(BloodPressure bloodPressure) async {
    var dbClient = await database;

    return await dbClient.insert(ApplicationConstants.DATABASE_TABLE, bloodPressure.toMap());
  }

  // Deleting specific data from the table with id condition
  Future<void> delete(int id) async {
    var dbClient = await database;

    return await dbClient.delete(ApplicationConstants.DATABASE_TABLE, where: 'id = ? ', whereArgs: [id]);
  }
}
