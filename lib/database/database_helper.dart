import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/pages/home.dart';


class DatabaseHelper{

  final String todoTable = 'todo';
  final String columnId = 'id';
  final String columnText = 'todoText';
  final String columnisDone = 'isDone';
 
 //global field = instance whicch calls [DatabaseHelper._init()] constructor
  static final DatabaseHelper instance = DatabaseHelper._init();

  //field for database
  static Database? _database;

  //private constructor
  DatabaseHelper._init();

  //open a connection 

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('todo_db');
    return _database!;
  }

  //initialize database, we define method where we get filepath
  Future<Database> _initDB(String filePath) async{

    //to store our db in our file storage system can use get
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{
    
    await db.execute('''
      create table $todoTable (
        $columnId text primary key,
        $columnText text,
        $columnisDone integer)
    ''');
     print("Database created!");
  
  }

		// Fetch Operation: Get all todo objects from database
		Future<List<Map<String, dynamic>>> getTodoMapList() async {
			Database db = await this.database;
	

	//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
			var result = await db.query(todoTable, orderBy: '$columnText ASC');
			return result;
		}

  Future<int> insertTodo(ToDo todo) async {
    var no = todo.id;
    var text = todo.todoText;
    var check = todo.isDone;
    print(todo.id);
    print(todo.todoText);
    print(todo.isDone);

print("Insert into $todoTable(id, todoText,isDone ) values( $no, $text, $check)");
    final db = await database;
    var hehe= await db.rawInsert('Insert into $todoTable(id, todoText,isDone ) values( \'$no\', \'$text\', $check)');
    return hehe;
  }

  Future<int> deleteTodo(String id) async {

    final db = await database;
    return await db.rawDelete('DELETE FROM $todoTable WHERE id = $id');
  }



  Future<List<ToDo>> getAllTodos() async {
    final db = await database;

    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
		int count = todoMapList.length;         // Count the number of map entries in db table
    
    
    List<ToDo> todoList = [];
			// For loop to create a 'todo List' from a 'Map List'
			for (int i = 0; i < count; i++) {
				todoList.add(ToDo.fromMap(todoMapList[i]));
			}
			return todoList;
  }
    //to close db
  Future close() async{
    //access db we have created before
    final db = await instance.database;
    db.close();
  }
  
  }

  