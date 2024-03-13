import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  String boxName;
  String listName;
  late Box<dynamic> _myBox;

  ToDoDatabase(this.boxName, this.listName) {
    boxName;
    listName;
    _myBox = Hive.box(boxName);
  }
  List toDoList = [];

  void crateInitialData() {
    List toDoList = [
      ["Make Tutorials", false],
      ["sharpen knifes", false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get(listName) ?? [];
  }

  void updateDatabase() {
    _myBox.put(boxName, listName);
  }
}
