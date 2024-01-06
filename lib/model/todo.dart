import 'package:flutter/material.dart';

const String todoTable = 'todo';
const String columnId = 'id';
const String columnText = 'todoText';
const String columnisDone = 'isDone';

class ToDo {
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({required String id, required String todoText}) {
    this.id = id;
    this.todoText = todoText;
    this.isDone = false;
  }

  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    todoText = map['todoText'];
    isDone = map['isDone'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      columnText: todoText,
      columnisDone: isDone == 1 ? true : false
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
