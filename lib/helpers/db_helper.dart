import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const listN = 'CREATE TABLE EList(listTitle TEXT PRIMARY KEY)';
  static const save =
      'CREATE TABLE SaveExercises(title TEXT PRIMARY KEY, listTitle TEXT,imgurl TEXT, videoUrlID TEXT, description TEXT,isPresentInSaveWorkout TEXT,FOREIGN KEY(listTitle) REFERENCES EList(listTitle) ON DELETE CASCADE)';

  // static Future<Database> databaseForSaveExerciseTable() async {
  //   final dbPath = await sql.getDatabasesPath();
  //   return sql.openDatabase(path.join(dbPath, 'SaveWorkouts5.db'),
  //       onCreate: (db, version) async {
  //     await db.execute(save);
  //   }, version: 1);
  // }

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'SaveWorkouts1.db'),
        onCreate: (db, version) async {
      await db.execute(listN);
      await db.execute(save);
    }, version: 1);
  }

  static Future<void> insertExercise(
      String table, Map<String, String> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertSaveWorkoutListName(
      String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getDataInTheList(
      String table, String listName) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM $table where listTitle=?', [listName]);
  }

  static Future<List<Map<String, dynamic>>> getList(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> removeExcercise(
      String table, String title, String listName) async {
    final db = await DBHelper.database();
    return db.rawDelete(
        'DELETE FROM $table where listTitle=? AND title=?', [listName, title]);
  }

  static Future<int> removeList(String table, String listName) async {
    final db = await DBHelper.database();
    return db.rawDelete('DELETE FROM $table where listTitle=?', [listName]);
  }
}
