import 'package:coconut_do/core/models/task_library.dart';
import 'package:coconut_do/core/storage/preferences_model.dart';
import 'package:coconut_do/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreferences = await SharedPreferences.getInstance();

  var taskLibrary = TaskLibrary();
  await taskLibrary.getInitialDataFromDatabase();

  runApp(ScopedModel<PreferencesModel>(
    model: PreferencesModel(sharedPreferences),
    child: ScopedModel<TaskLibrary>(
      model: taskLibrary,
      child: const CoreApp(),
    ),
  ));
}


class CoreApp extends StatelessWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScopedModelDescendant<PreferencesModel>(
      builder: (context, child, model) => MaterialApp(
        title: 'Coconut Do',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      )
    );
  }
}