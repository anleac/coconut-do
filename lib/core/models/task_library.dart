import 'package:coconut_do/core/models/task.dart';
import 'package:coconut_do/core/storage/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TaskLibrary extends Model {
  static TaskLibrary of(BuildContext context) => ScopedModel.of<TaskLibrary>(context);

  final Map<int, Task> _tasks = {};
  Map<int, Task> get tasks => _tasks;

  getInitialDataFromDatabase() async {
    await DatabaseProvider.initDatabase();
    var tasks = await DatabaseProvider.getAllTasks();
    for (var task in tasks) {
      _tasks.putIfAbsent(task.id, () => task);
    }
  }

  notifySoundStream() {
    notifyListeners();
  }
}
