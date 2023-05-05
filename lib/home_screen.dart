import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoController = TextEditingController();

  late Todo todo;
  final List<Todo> todos = [];

  @override
  void initState() {
    super.initState();

    todo = Todo(
      id: 0,
      title: '',
      isDone: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: todoController,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  todo.id = Random().nextInt(1000);
                  todo.title = value;
                  todo.isDone = false;

                  todos.add(todo);
                  debugPrint('Todo is created: $todo');
                  todoController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
