import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/todo_service.dart';

// provider to write todo to firestore
final todoServiceProvider = Provider.autoDispose<TodoService>((ref) {
  return TodoService();
});

// provider to read todo from firestore
final todosProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
  final todoService = ref.watch(todoServiceProvider);
  return todoService.readTodos();
});
