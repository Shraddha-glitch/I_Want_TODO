import 'package:flutter/material.dart';

abstract class TodoEvent {}

class ViewTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String todoText;

  AddTodoEvent(this.todoText);
}

class UpdateTodoEvent extends TodoEvent {
  final String todoId;
  final bool isDone;

  UpdateTodoEvent(this.todoId, this.isDone);
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;

  DeleteTodoEvent(this.todoId);
}
