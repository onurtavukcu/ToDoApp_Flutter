import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/ToDoTile.dart';
import 'package:flutter_application_1/Pages/dialogBox.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  String pageTitle;
  String boxName;
  String list;
  BuildContext contexts;
  ToDoDatabase databases;

  Homepage(
      this.pageTitle, this.boxName, this.list, this.contexts, this.databases) {
    pageTitle;
    boxName;
    list;
    contexts;
    databases;
    super.key;
  }
  @override
  State<Homepage> createState() =>
      _HomePageState(pageTitle, boxName, list, contexts, databases);
}

class _HomePageState extends State<Homepage> {
  late String pageTitles;
  late String boxNames;
  late String lists;
  late BuildContext relatedContext;
  late ToDoDatabase db;

  _HomePageState(String title, String boxName, String list,
      BuildContext context, ToDoDatabase database) {
    pageTitles = title;
    boxNames = boxName;
    lists = list;
    relatedContext = context;
    db = database;
  }

  final _controller = TextEditingController();

  @override
  void initState() {
    final _mybox = Hive.box(boxNames);

    if (_mybox.get(lists) == null) {
      db.crateInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void saveNewTask() {
    setState(() {
      if (!_controller.text.isEmpty) db.toDoList.add([_controller.text, false]);
      _controller.clear();
      db.updateDatabase();
    });
    Navigator.of(context).pop();
  }

  void cancelButton() {
    Navigator.of(context).pop();
    _controller.text = "";
  }

  void createNewTask() {
    // debugPrint('data: $isActive');
    showDialog(
        context: context,
        builder: (relatedContext) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: cancelButton,
          );
        });
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 174, 174, 174),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(
            pageTitles,
            style: TextStyle(color: Colors.black, fontSize: 36),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              deleteFunction: (relatedContext) => deleteTask(index),
            );
          },
        ));
  }
}
