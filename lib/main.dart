//Hello everyone this is me sapna fazal and i have developad a to do list app for prodigy info tach as an internee , this is my task 2



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
      _textFieldController.clear();
    }
  }

  void _editTodoItem(int index, String newTask) {
    setState(() {
      _todoItems[index] = newTask;
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptEditTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _editTextFieldController = TextEditingController();
        _editTextFieldController.text = _todoItems[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            backgroundColor:const  Color(0xFF2C3E50),
            title:const  Text('Edit task', style: TextStyle(color: Colors.white)),
            content: TextField(
              controller: _editTextFieldController,
              decoration: const InputDecoration(
                hintText: 'Enter new task here',
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                child:const  Text('CANCEL', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('SAVE', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _editTodoItem(index, _editTextFieldController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF34495E),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          todoText,
          style:const  TextStyle(color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.check_box, color: Colors.pinkAccent),
              onPressed: () => _deleteTodoItem(index),
            ),
            IconButton(
              icon:const Icon(Icons.edit, color: Colors.yellowAccent),
              onPressed: () => _promptEditTodoItem(index),
            ),
            IconButton(
              icon:const Icon(Icons.delete, color: Colors.cyanAccent),
              onPressed: () => _deleteTodoItem(index),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('TO-DO LIST', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
               const  SizedBox(height: 80.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          hintText: 'Enter a Todo...',
                          hintStyle:const  TextStyle(color: Color.fromARGB(255, 0, 110, 244)),
                          filled: true,
                          fillColor:const  Color.fromARGB(255, 245, 187, 245),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style:const  TextStyle(color: Color.fromARGB(255, 0, 110, 244)),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () => _addTodoItem(_textFieldController.text),
                      style: ElevatedButton.styleFrom(
                        primary:const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(child: _buildTodoList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
