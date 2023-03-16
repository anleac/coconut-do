class Task {
  int id;
  String title;
  String description;
  bool isCompleted;
  
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Task.fromMap(Map<String, dynamic> values) => Task(
    id: values["id"],
    title: values["title"],
    description: values["description"],
    isCompleted: values["isCompleted"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "isCompleted": isCompleted ? 1 : 0,
  };
}
