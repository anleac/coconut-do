import 'dart:io';

import 'package:coconut_do/core/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  // The actual database name that holds everything
  static const _databaseName = "co123and24";

  static const _taskTableName = "coconutTable";

  static const _databaseVersion = 1;

  static const _createTaskTable = 
    "CREATE TABLE $_taskTableName ("
      "id INTEGER PRIMARY KEY,"
      "name TEXT,"
      "isCompleted BIT"
    ")";

  static late Database _database;
  static initDatabase() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, _databaseName);

    try {
      await Directory(databasePath).create(recursive: true);
    } catch (_) {}

    _database = await openDatabase(
      path,version: _databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute(_createTaskTable);
      }
    );
  }

  static addTask(Task task) async {
    await _database.insert(_taskTableName, task.toMap());
  }

  static updateTaskStatus(Task task) async {
    const updateString = "UPDATE $_taskTableName SET isCompleted = ? WHERE id = ?";
    return await _database.rawUpdate(updateString, [task.isCompleted, task.id]);
  }

  static deleteTask(int id) async {
    const deleteString = "DELETE FROM $_taskTableName WHERE id = ?";
    return await _database.rawDelete(deleteString, [id]);
  }

  static Future<List<Task>> getAllTasks() async {
    var res = await _database.query(_taskTableName);
    return res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
  }
}
