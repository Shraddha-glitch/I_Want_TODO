import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/todo_event.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widget/todo_item.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/repository/todo_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoController = TextEditingController();
  List<ToDo> todosList = [];

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper.instance.getAllTodos();
    setState(() {
      todosList = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, List<ToDo>>(
        builder: (context, state) {
          return _buildTodoList(state);
        },
      ),
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildTodoList(List<ToDo> todosList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          _buildSearchBox(),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<TodoBloc>(context).add(ViewTodoEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      elevation: 10,
                    ),
                    child: const Icon(Icons.view_array),
                  ),
                ),
                for (ToDo todo in todosList)
                  if (todo != null) // Check if the todo is not null
                    ToDoItem(
                      todo: todo,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: () => _handleDeleteChange(todo.id!),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdBlack),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/man.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 5,
              top: 20,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow()],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                hintText: 'Add a new todo item',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<TodoBloc>(context)
                  .add(AddTodoEvent(_todoController.text));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: tdBlue,
              elevation: 10,
            ),
            child: const Text(
              '+',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleToDoChange(ToDo todo) {
    if (todo.isDone != null) {
      BlocProvider.of<TodoBloc>(context)
          .add(UpdateTodoEvent(todo.id!, !(todo.isDone ?? false)));
    }
  }

  void _handleDeleteChange(String id) {
    BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(id));
  }
}
