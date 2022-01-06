import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DBHelper {
  static final int _version = 1;

  static final String _tableName = 'tasks';

  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in database path');

        // open the database
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          debugPrint('Creating a new one');
          await db.execute(
            'CREATE TABLE $_tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title STRING, note TEXT, date STRING,'
            'startTime STRING,endTime STRING,'
            'remind INTEGER, repeat STRING,'
            'color INTEGER,'
            'isCompleted INTEGER)',
          );
        });
      } catch (erorr) {
        debugPrint(erorr.toString());
      }
    }
  }

  static Future<int> insertInDB(Task task) async {
    return await _db!.insert(_tableName, task.toJson());
  }

  static Future<int> deleteFromDB(Task task) async {
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }
  static Future<int> deleteAllFromDB() async {
    return await _db!.delete(_tableName);
  }
   static Future<List<Map<String, dynamic>>>queryFromDB() async {
    return await _db!.query(_tableName);
  }

  static Future<int> updateInDB(Task task) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted  = ?
    WHERE id = ?
    
    
    
    ''', [1, task.id]);
  }
}
