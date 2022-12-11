class Task {
  int id;
  String name;
  bool isCompleted;
  
  Task({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  factory Task.fromMap(Map<String, dynamic> values) => Task(
      id: values["id"],
      name: values["name"],
      isCompleted: values["isCompleted"] == 1,
  );

  Map<String, dynamic> toMap() => {
      "id": id,
      "name": name,
      "isCompleted": isCompleted ? 1 : 0,
  };
}
