import 'package:flutter/material.dart';

const String todoTable ='todo';
const String columnId = 'id';
const String columnText = 'todoText';
const String columnisDone = 'isDone';


class ToDo{
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({required String id, required String todoText}) {
    this.id = id;
    this.todoText = todoText;
    this.isDone = false;
  }

   ToDo.fromMap(Map<String, dynamic> map){
    id = map['id'];
    todoText = map['todoText'] ;
    isDone = map['isDone'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap(){
    final map = <String, dynamic>{
      columnText: todoText,
      columnisDone: isDone == 1 ? true : false
    };
    if(id != null){
      map['id'] = id;
    }
    return map;
  }

 


  // ToDo({
  //   required this.id,
  //   required this.todoText,
  //      this.isDone=false,
  // });

  // static List<ToDo> todoList(){
  //   return[
  //     ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
  //     ToDo(id: '02', todoText: 'Breakfast', isDone: true),
  //     ToDo(id: '03', todoText: 'Washing Clothes', ),
  //     ToDo(id: '04', todoText: 'Ready for office', ),
  //     ToDo(id: '05', todoText: 'Make todo list app',),
  //     ToDo(id: '06', todoText: 'Meeting with client',),
  //     ToDo(id: '07', todoText: 'Buy Groceries',),
  //     ToDo(id: '08', todoText: 'Dinner Time'),
  //   ];
  // }

}