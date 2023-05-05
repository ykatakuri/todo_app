class Todo {
  int? id;
  String title;
  bool? isDone;

  Todo({
    this.id,
    required this.title,
    this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as int?,
        title: json['title'] as String,
        isDone: json['isDone'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isDone': isDone,
      };
}
