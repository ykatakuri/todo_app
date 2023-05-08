import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/todo_model.dart';

class TodoService {
  // Get an instance of FirebaseFirestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTodo(Todo todo) {
    return firestore.collection('todos').add(<String, dynamic>{
      'id': '',
      'title': todo.title,
      'isDone': todo.isDone,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }).then((value) => firestore.collection('todos').doc(value.id).update({
          'id': value.id,
        }));
  }

  // read todo from firestore
  Stream<List<Todo>> readTodos() {
    return firestore
        .collection('todos')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo(
          id: doc['id'] as String,
          title: doc['title'] as String,
          isDone: doc['isDone'] as bool,
        );
      }).toList();
    });
  }

  // update todo in firestore
  Future<void> updateTodo({
    required String id,
    required String title,
    required bool isDone,
  }) {
    return firestore.collection('todos').doc(id).update(<String, dynamic>{
      'title': title,
      'isDone': isDone,
    });
  }
}
