import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/todo_model.dart';

class TodoService {
  Future<DocumentReference> addTodo(Todo todo) {
    return FirebaseFirestore.instance.collection('todos').add(<String, dynamic>{
      'title': todo.title,
      'isDone': todo.isDone,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
