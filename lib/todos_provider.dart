import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/todo_service.dart';

final todosProvider = StateProvider<List<Todo>>((ref) {
  return [
    Todo(
      id: 0,
      title: 'Buy milk',
      isDone: false,
    ),
    Todo(
      id: 1,
      title: 'Buy eggs',
      isDone: false,
    ),
    Todo(
      id: 2,
      title: 'Buy bread',
      isDone: false,
    ),
  ];
});

// provider to write todo to firestore
final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService();
});
