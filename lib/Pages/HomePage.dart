import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/ToDoTile.dart';
import 'package:flutter_application_1/Pages/dialogBox.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  Homepage() {
    super.key;
  }

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  final _mybox = Hive.box('mybox');

  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.crateInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    // debugPrint('data: $isActive');
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: cancelButton,
          );
        });
    db.updateDatabase();
  }

  void cancelButton() {
    Navigator.of(context).pop();
    _controller.text = "";
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
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: const Text("Dont Forget"),
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
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
