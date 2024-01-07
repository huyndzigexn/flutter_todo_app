import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> todos = [];
  TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Color.fromARGB(255, 234, 214, 183),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      todos[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _deleteTodo(index);
                          print('Delete button pressed');
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(33),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _todoController,
                    onFieldSubmitted: (value) {
                      _addTodo(value);
                      _todoController.clear(); // Xoá chữ trong ô input
                    },
                    decoration: InputDecoration(
                      hintText: 'Add a new todo',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addTodo(_todoController.text);
                    _todoController.clear(); // Xoá chữ trong ô input
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addTodo(String title) {
    if (title.isNotEmpty) {
      setState(() {
        todos.add(TodoItem(title: title, isCompleted: false));
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, required this.isCompleted});
}
