import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../todo/todo.dart';

class TodoDb {
  static final TodoDb _singleton = TodoDb._internal();

  TodoDb._internal();

  factory TodoDb() => _singleton;

  DatabaseFactory dbFactory = databaseFactoryIo;
  final store = intMapStoreFactory.store('todos');
  Database? _database;

  Future<Database> get database async {
    _database ??= await _openDb().then((value) {
      _database = value;
      return _database;
    });
    return _database!;
  }

  Future _openDb() async {
    final docsPath = await getApplicationCacheDirectory();
    final dbpath = join(docsPath.path, 'todos.db');
    final db = await dbFactory.openDatabase(dbpath);
    return db;
  }

  Future insertTodo(Todo todo) async {
    await store.add(_database!, todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(_database!, todo.toMap(), finder: finder,);
  }

  Future deleteTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database!, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_database!);
  }

  Future<List<Todo>> getTodos() async {
    await database;
    final finder = Finder(sortOrders: [SortOrder('priority'), SortOrder('id')]);
    final todosSnapshot = await store.find(_database!, finder: finder);
    return todosSnapshot.map((snapShot){
      final todo = Todo.formMap(snapShot.value);
      todo.id = snapShot.key;
      return todo;
    }).toList();
  }
}
