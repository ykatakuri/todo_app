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
  List<Todo> todos = [];

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
                  setState(() {
                    todo = Todo(
                      id: Random().nextInt(100),
                      title: value,
                      isDone: false,
                    );

                    todos.add(todo);
                    debugPrint('Todo ID: ${todo.id}');
                    todoController.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 50),
            if (todos.isNotEmpty) ...[
              Text(
                'TODOs',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blue.shade700),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  if (todo.isDone!) {
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          setState(() {
                            todo.isDone = value!;
                            debugPrint(
                                'Todo ${todo.id} is updated: ${todo.isDone}');
                          });
                        },
                        activeColor: Colors.grey,
                      ),
                      textColor: Colors.grey,
                    );
                  } else {
                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          setState(() {
                            todo.isDone = value!;
                            debugPrint(
                                'Todo ${todo.id} is updated: ${todo.isDone}');
                          });
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
