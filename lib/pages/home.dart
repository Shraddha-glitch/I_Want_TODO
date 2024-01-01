import 'dart:ffi';

import 'package:todoapp/constants/colors.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/widget/todo_item.dart';
import '../model/todo.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/model/todo.dart';

class HomePage extends StatefulWidget{
   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoController = TextEditingController();
  List<ToDo> todosList = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
    print("...number of items ${todosList.length}");
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper.instance.getAllTodos();
    setState(() {
      todosList = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, 
            vertical:15),
            child: Column(
              children: [
               searchBox(),
               Expanded(
                 child:  ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      child: const Text('All ToDos',style: TextStyle(fontSize: 28,
                      fontWeight: FontWeight.bold, 
                      ),
                      ),
                    ),
                    for(ToDo todoo in todosList )
                    ToDoItem(todo: todoo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _handleDeleteChange, 
                      ),
                      //2nd todo is value which we are getting from for(ToDo ***todo*** in todosList ), todosList bata aaune and 1st wala todo is todo_item.dart ko widget is expecting

                  ],
                 ),
               )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child:
               Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  left: 20,
                  right: 5,
                  top: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal:20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                 boxShadow: const [BoxShadow(),
                 ],
                 borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(
                    hintText: 'Add a new todo item',
                    border: InputBorder.none),
                ),
              ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ElevatedButton(
                onPressed: () async{
                   await _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  elevation: 10,
                ),
                child: const Text('+', style: TextStyle(fontSize: 40,
                ),
                ),
                ),
            ),
            ],),
          ), 
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
          todo.isDone = !(todo.isDone??false);
    });
  }

  void _handleDeleteChange(String id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    await _loadTodos();
  }

Future<void> _addToDoItem(String toDo) async {
  final newTodo = ToDo(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    todoText: toDo
  );

  await DatabaseHelper.instance.insertTodo(newTodo);
  await _loadTodos();
  _todoController.clear();
}




  Widget searchBox(){
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
        children: [ const
        Icon(Icons.menu,
        color: tdBlack,
        size: 30,),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset('assets/images/man.jpg'),
          ),
        ),
      ]),
    );
  }
}