import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/todo_event.dart';
import '../../constants/colors.dart';
import '../../model/todo.dart';
import 'package:todoapp/database/database_helper.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    this.onToDoChanged,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          if (onToDoChanged != null) {
            onToDoChanged(todo);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          (todo.isDone ?? false)
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration:
                (todo.isDone ?? false) ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(todo.id!));
            },
          ),
        ),
      ),
    );
  }
}
