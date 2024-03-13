import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/HomePage.dart';
import 'package:flutter_application_1/data/database.dart';

class ToDoList extends StatefulWidget {
  String pageTitle;
  String box;
  String list;
  BuildContext context;
  ToDoDatabase db;

  ToDoList(this.pageTitle, this.box, this.list, this.context, this.db) {
    pageTitle;
    box;
    list;
    context;
    db;
    super.key;
  }

  @override
  State<ToDoList> createState() => _ToDoList(pageTitle, box, list, context, db);
}

class _ToDoList extends State<ToDoList> {
  late String pageTitles;
  late String boxes;
  late String lists;
  late BuildContext contexts;
  late ToDoDatabase dbs;

  _ToDoList(String title, String box, String list, BuildContext context,
      ToDoDatabase db) {
    pageTitles = title;
    boxes = box;
    lists = list;
    contexts = context;
    dbs = db;
  }

  @override
  Widget build(BuildContext context) {
    return new Homepage(pageTitles, boxes, lists, contexts, dbs);
  }
}
