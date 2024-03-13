import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/BuyList.dart';
import 'package:flutter_application_1/Pages/ToDoList.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  var todoBox = await Hive.openBox('todoBox');
  var buyBox = await Hive.openBox('buyBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ObburApp',
      home: PageView(scrollDirection: Axis.horizontal, children: [
        ToDoList("ToDoList", "todoBox", "toDoList", context,
            new ToDoDatabase("todoBox", "buyList")),
        BuyList("BuyList", "buyBox", "buyList", context,
            new ToDoDatabase("buyBox", "buyList")),
      ]),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
