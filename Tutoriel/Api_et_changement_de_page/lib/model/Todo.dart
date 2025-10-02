class Todo {

  int id;
  String name;
  bool isCompleted;

  Todo({required this.id, required this.name, required this.isCompleted});

  Todo.fromJson(Map<String, dynamic> json):
        this(id: json['id'], name: json['title'], isCompleted: json['completed']);

}