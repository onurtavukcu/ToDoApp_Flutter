import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/ToDoTile.dart';
import 'package:flutter_application_1/Pages/dialogBox.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homapage extends StatefulWidget {
  Homapage() {
    super.key;
  }

  @override
  State<Homapage> createState() => _HomaPageState();
}

class _HomaPageState extends State<Homapage> {
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

  //checkbox tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
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
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
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
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text("To Do List"),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}


// body: ListView(  
//         children: [
//           ToDoTile(
//             taskName: "Make Tutorials",
//             taskCompleted: true,
//             onChanged: (p0) {},
//           ),
//           ToDoTile(
//             taskName: "Sharpen Knifes",
//             taskCompleted: false,
//             onChanged: (p0) {},
//           ),
//         ],
//       ),