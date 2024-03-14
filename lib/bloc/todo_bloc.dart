import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../data/todo_db.dart';
import '../todo/todo.dart';

class TodoBloc {
  TodoDb? db;
  List<Todo>? todoList;

  final _todoStreamController = StreamController<List<Todo>>.broadcast();
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  Stream<List<Todo>> get todos => _todoStreamController.stream;

  StreamSink<List<Todo>> get todosSink => _todoStreamController.sink;

  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;

  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;

  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  Future getTodos() async {
    List<Todo> todos = await db!.getTodos(); // db 에서 To.do 객체 리스트로 가지고 옴
    todoList = todos;
    todosSink.add(todos);
  }

  /// 생성자
  TodoBloc() {
    db = TodoDb();
    getTodos();
    // _todoStreamController.stream.listen((todos) => todos); // 불필요 하대서 일단 제거

    _todoInsertController.stream.listen((Todo todo) {
      db!.insertTodo(todo).then((value) => getTodos());
    });

    _todoUpdateController.stream.listen((Todo todo) {
      db!.updateTodo(todo).then((value) => getTodos());
    });

    _todoDeleteController.stream.listen((Todo todo) {
      db!.deleteTodo(todo).then((value) => getTodos());
    });
  }

  void dispose(){
    _todoStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }

}
