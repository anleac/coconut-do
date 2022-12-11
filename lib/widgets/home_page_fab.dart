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
  }
}