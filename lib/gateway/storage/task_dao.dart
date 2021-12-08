import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/domain/entity/task_entity.dart';
import 'package:todo_list/domain/gateway/task_gateway.dart';
import 'package:todo_list/gateway/resources/keys_database.dart';

const List<String> _columnsTask = [
  KeysDatabase.id,
  KeysDatabase.categoryId,
  KeysDatabase.name,
  KeysDatabase.description,
  KeysDatabase.dateStart,
  KeysDatabase.dateEnd,
  KeysDatabase.isComplete,
];

class TaskDao extends TaskGateway<TaskEntity> {
  final Database database;

  TaskDao({required this.database});

  final int _currentVersion = 1;

  @override
  Future<void> connect(String path) async {
    // TODO: implement getAll
    throw UnimplementedError();
    // Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // Delete the database
    await deleteDatabase(path);

    // open the database
    Database database = await openDatabase(path, version: _currentVersion, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE Task (id INTEGER PRIMARY KEY, name TEXT,  INTEGER)');
    });
  }

  @override
  Future<List<TaskEntity>> getAll() async {
    final List<Map<String,dynamic>> maps = await database.query(
      KeysDatabase.taskTableName,
      columns: _columnsTask,
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => TaskEntity.fromJson(e)).cast<TaskEntity>().toList();
    }

    return [];
  }

  @override
  Future<TaskEntity> add(TaskEntity item) async {
    print(item.toJson());
    final id = await database.insert(KeysDatabase.taskTableName, item.toJson());
    item.copyWith(id: id);

    print(item.toJson());
    // final dbItem = await database.
    return item;
  }

  @override
  Future<void> addAll(List<TaskEntity> list) async {
    // TODO: implement addAll
    throw UnimplementedError();
  }

  @override
  Future<TaskEntity> update(TaskEntity item) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(TaskEntity item) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() async {
    // TODO: implement deleteAll
    throw UnimplementedError();
    // await database.rawInsert(sql);
  }

  @override
  Future<void> close() async {
    await database.close();
  }

  @override
  int getLastId(List<TaskEntity> list) {
    if (list.isNotEmpty) {
      print(list);
      list.sort((a, b) => a.id < b.id ? 1 : 0);
      print(list);
      return list.first.id;
    } else {
      return 0;
    }
  }
}
