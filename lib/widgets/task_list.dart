import 'package:coconut_do/core/models/task_library.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TaskLibrary>(builder: (context, child, library) {
      var allTasks = library.allTasks;
      
      return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(color: Colors.black),
        itemCount: allTasks.length,
        itemBuilder: (BuildContext context, int index) {
          var task = allTasks[index];
          return ListTile(
            title: Text(task.title),
            leading: IconButton(
              icon: Icon(task.isCompleted ? Icons.check_circle : Icons.check_circle_outline),
              onPressed: () => library.toggleCompleted(task),),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => library.deleteTask(task),),);
        });
    });
  }
}