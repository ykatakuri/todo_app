import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/todo_model.dart';

final todosProvider = StateProvider<Todo>((ref) {
  return Todo(
    id: 0,
    title: '',
    isDone: false,
  );
});
