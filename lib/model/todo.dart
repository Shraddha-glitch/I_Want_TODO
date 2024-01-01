// todo.dart
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class ToDo {
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoToJson(this);

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Breakfast', isDone: true),
      ToDo(id: '03', todoText: 'Washing Clothes'),
      ToDo(id: '04', todoText: 'Ready for office'),
      ToDo(id: '05', todoText: 'Make todo list app'),
      ToDo(id: '06', todoText: 'Meeting with client'),
      ToDo(id: '07', todoText: 'Buy Groceries'),
      ToDo(id: '08', todoText: 'Dinner Time'),
    ];
  }
}
