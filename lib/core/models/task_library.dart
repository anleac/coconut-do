import 'dart:math';

import 'package:coconut_do/core/models/task.dart';
import 'package:coconut_do/core/storage/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TaskLibrary extends Model {
  static TaskLibrary of(BuildContext context) => ScopedModel.of<TaskLibrary>(context);

  final Map<int, Task> _tasks = {};
  Map<int, Task> get tasks => _tasks;
  List<Task> get allTasks => _tasks.values.toList();

  getInitialDataFromDatabase() async {
    await DatabaseProvider.initDatabase();
    var tasks = await DatabaseProvider.getAllTasks();
    for (var task in tasks) {
      _tasks.putIfAbsent(task.id, () => task);
    }
  }

  void addTask(String newTask) async {
    int intToUse =  _tasks.isNotEmpty ? _tasks.keys.reduce(max) + 1 : 0;
    var taskToAdd = Task(id: intToUse, title: newTask, description: '', isCompleted: false);
    _tasks.putIfAbsent(taskToAdd.id, () => taskToAdd);
    await DatabaseProvider.addTask(taskToAdd);
    notifySoundStream();
  }

  void toggleCompleted(Task task) async {
    task.isCompleted = !task.isCompleted;
    _tasks.update(task.id, (value) => task);
    await DatabaseProvider.updateTaskStatus(task);
    notifySoundStream();
  }

  void deleteTask(Task task) async {
    _tasks.remove(task.id);
    await DatabaseProvider.deleteTask(task.id);
    notifySoundStream();
  }

  notifySoundStream() {
    notifyListeners();
  }
}
