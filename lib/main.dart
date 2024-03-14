import 'package:book_todo_list/bloc/todo_bloc.dart';
import 'package:book_todo_list/todo/todo.dart';
import 'package:book_todo_list/todo_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: firstPage()));

class firstPage extends StatefulWidget {
  const firstPage({super.key});

  @override
  State<firstPage> createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  TodoBloc todoBloc = TodoBloc();
  List<Todo>? todos;
  Todo basicTodo = Todo(name: '', description: '', completeBy: '', priority: 0);

  @override
  void dispose() {
    super.dispose();
    todoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: StreamBuilder(
          stream: todoBloc.todos,
          initialData: todos,
          builder: (context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: (snapshot.hasData) ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(snapshot.data[index].id.toString()),
                    onDismissed: (_) =>
                        todoBloc.todoDeleteSink.add(snapshot.data[index]),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${snapshot.data[index].priority}'),
                      ),
                      title: Text('${snapshot.data[index].name}'),
                      subtitle: Text('${snapshot.data[index].description}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoScreen(
                                      todo: snapshot.data[index],
                                      isNew: false)));
                        },
                      ),
                    ));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TodoScreen(todo: basicTodo, isNew: true)));
        },
      ),
    );
  }
}
