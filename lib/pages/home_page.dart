import 'package:coconut_do/widgets/home_page_drawer.dart';
import 'package:coconut_do/widgets/home_page_fab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Coconut Do'),
      ),
      floatingActionButton: const HomePageFab(),
      drawer: const HomePageDrawer(),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}