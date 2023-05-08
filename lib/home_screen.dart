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
    final AsyncValue<List<Todo>> todos = ref.watch(todosProvider);

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
                    ref.read(todoServiceProvider).addTodo(Todo(
                          id: '',
                          title: value,
                          isDone: false,
                        ));

                    todoController.clear();
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
            // display todos from firestore
            todos.when(
              data: (todos) {
                if (todos.isEmpty) {
                  return const Text('No todos');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return ListTile(
                      title: Text(todo.title),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          ref.read(todoServiceProvider).updateTodo(
                                id: todo.id,
                                title: todo.title,
                                isDone: value!,
                              );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => const Text(
                'Oops, something unexpected happened',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
