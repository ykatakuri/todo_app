import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/todos_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    required this.title,
    super.key,
  });

  final String title;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final formKey = GlobalKey<FormState>(debugLabel: '_HomeScreenState');
  final todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosProvider);

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
            Form(
              key: formKey,
              child: TextFormField(
                controller: todoController,
                decoration: const InputDecoration(
                  labelText: 'What needs to be done?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.trim().isEmpty
                    ? 'Please enter some text for the todo'
                    : null,
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    ref.read(todosProvider.notifier).update((state) => [
                          ...state,
                          Todo(
                            id: Random().nextInt(100),
                            title: value,
                            isDone: false,
                          ),
                        ]);

                    todoController.clear();
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
            if (todos.isNotEmpty) ...[
              Text(
                'TODOs',
                style: Theme.of(context).textTheme.displaySmall,
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
                          ref.read(todosProvider.notifier).state = [
                            for (final todo in todos)
                              if (todo.id == todos[index].id)
                                Todo(
                                  id: todo.id,
                                  title: todo.title,
                                  isDone: value,
                                )
                              else
                                todo
                          ];
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
                          ref.read(todosProvider.notifier).state = [
                            for (final todo in todos)
                              if (todo.id == todos[index].id)
                                Todo(
                                  id: todo.id,
                                  title: todo.title,
                                  isDone: value,
                                )
                              else
                                todo
                          ];
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
