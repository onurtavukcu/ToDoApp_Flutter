import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/HomePage.dart';
import 'package:flutter_application_1/data/database.dart';

class BuyList extends StatefulWidget {
  String pageTitle;
  String box;
  String list;
  BuildContext context;
  ToDoDatabase db;
  BuyList(this.pageTitle, this.box, this.list, this.context, this.db) {
    pageTitle;
    box;
    list;
    context;
    super.key;
    db;
  }

  @override
  State<BuyList> createState() => _BuyList(pageTitle, box, list, context, db);
}

class _BuyList extends State<BuyList> {
  late String pageTitles;
  late String boxes;
  late String lists;
  late BuildContext contexts;
  late ToDoDatabase dbs;

  _BuyList(String title, String box, String list, BuildContext context,
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
