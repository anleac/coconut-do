import 'package:coconut_do/core/models/task_library.dart';
import 'package:coconut_do/helpers/dialogue_helper.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePageFab extends StatefulWidget {
  const HomePageFab({Key? key}) : super(key: key);

  @override
  State<HomePageFab> createState() => _HomePageFabState();
}

class _HomePageFabState extends State<HomePageFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _handleFabPress(context),
      child: const Icon(Icons.add)); 
  }

  Future<void> _handleFabPress(BuildContext context) async {
    // Add a task
    var taskLibrary = TaskLibrary.of(context);
    var dialogueAdd = await DialogueHelper.addNewTask(context);
    if (dialogueAdd != null) {
      taskLibrary.addTask(dialogueAdd);
    }
  }
}