import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/pages/home.dart';
import 'package:todoapp/repository/todo_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: BlocProvider(
        create: (context) => TodoBloc(TodoRepository(DatabaseHelper.instance)),
        child: const HomePage(),
      ),
    );
  }
}

void ensureInitialized() {}
