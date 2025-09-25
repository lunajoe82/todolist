import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  // Lista de tareas
  List<String> tasks = [];
  // Controlador para el campo de texto
  TextEditingController taskController = TextEditingController();

  // Función para agregar una tarea
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
        taskController.clear(); // Limpiar el campo de texto
      });
    }
  }

  // Función para eliminar una tarea
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Función para marcar una tarea como completada
  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index] = tasks[index] + " ✅";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tareas'),
      ),
      body: Column(
        children: [
          // Campo de texto para agregar tareas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Escribe una tarea...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTask,
                ),
              ],
            ),
          ),
          // Lista de tareas
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => toggleTaskCompletion(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => addTask,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}