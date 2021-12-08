library database;

import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'sql/version_one.dart';

const int _currentVersion = 1;

Future<Database> initBase() async {
  try {
    // Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo_app.db');

// Delete the database
    await deleteDatabase(path);

// open the database
    Database database = await openDatabase(path, version: _currentVersion, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      // await db.execute(_createTableCategory);
      await db.execute(_createTableTask);
    });

    log('done init database');

    return database;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

//     required int id,
//     required int categoryId,
//     required String name,
//     String? description,
//     DateTime? dateStart,
//     DateTime? dateEnd,
//     @Default(false) bool isComplete,
