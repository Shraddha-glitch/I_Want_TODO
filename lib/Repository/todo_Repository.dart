import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';

class TodoRepository {
  final DatabaseHelper databaseHelper;

  TodoRepository(this.databaseHelper);

  Future<List<ToDo>> getAllTodos() async {
    return await databaseHelper.getAllTodos();
  }

  Future<void> addTodo(String todoText) async {
    await databaseHelper.insertTodo(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: todoText,
    ));
  }

  Future<void> deleteTodo(String todoId) async {
    await databaseHelper.deleteTodo(todoId);
  }

  Future<void> updateTodoStatus(String todoId, bool isDone) async {
    await databaseHelper.updateTodoStatus(todoId, isDone);
  }
}
