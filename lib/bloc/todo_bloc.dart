import 'package:bloc/bloc.dart';
import 'package:todoapp/bloc/todo_event.dart';

import 'package:todoapp/model/todo.dart';
import 'package:todoapp/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, List<ToDo>> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super([]) {
    on<ViewTodoEvent>(_onViewTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
  }

  void _onViewTodo(ViewTodoEvent event, Emitter<List<ToDo>> emit) async {
    emit(await repository.getAllTodos());
  }

  void _onAddTodo(AddTodoEvent event, Emitter<List<ToDo>> emit) async {
    await repository.addTodo(event.todoText);
    // emit(await repository.getAllTodos());
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<List<ToDo>> emit) async {
    await repository.updateTodoStatus(event.todoId, event.isDone);
    emit(await repository.getAllTodos());
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<List<ToDo>> emit) async {
    await repository.deleteTodo(event.todoId);
    emit(await repository.getAllTodos());
  }
}
