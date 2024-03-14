import 'package:book_todo_list/bloc/todo_bloc.dart';
import 'package:book_todo_list/main.dart';
import 'package:flutter/material.dart';

import 'todo/todo.dart';

class TodoScreen extends StatelessWidget {
  final Todo todo;
  final bool isNew;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();
  final TodoBloc bloc = TodoBloc();

  TodoScreen({super.key, required this.todo, required this.isNew});

  Future save() async {
    todo.name = txtName.text;
    todo.description = txtDescription.text;
    todo.completeBy = txtCompleteBy.text;
    todo.priority = int.parse(txtPriority.text);
    if (isNew) {
      bloc.todoInsertSink.add(todo);
    } else {
      bloc.todoUpdateSink.add(todo);
    }
  }

  @override
  Widget build(BuildContext context) {

    txtName.text = todo.name;
    txtDescription.text = todo.description;
    txtCompleteBy.text = todo.completeBy;
    txtPriority.text = todo.priority.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: txtName,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: txtDescription,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: txtCompleteBy,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Complete By'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: txtPriority,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Priority'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                child: const Text('SAVE'),
                onPressed: () {
                  save().then((_) => Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context)=>firstPage()), (route) => false));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
