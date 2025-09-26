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
          primarySwatch: Colors.green,
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
  List<String> filteredTasks = [];
  // Controladores
  TextEditingController taskController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTasks = tasks;
    searchController.addListener(_filterTasks);
  }

  // Función para filtrar tareas
  void _filterTasks() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredTasks = tasks
          .where((task) => task.toLowerCase().contains(query))
          .toList();
    });
  }

  // Función para agregar una tarea
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
        taskController.clear();
        _filterTasks(); // actualizar lista filtrada
      });
    }
  }

  // Función para eliminar una tarea
  void removeTask(int index) {
    setState(() {
      tasks.remove(filteredTasks[index]);
      _filterTasks();
    });
  }

  // Función para marcar una tarea como completada
  void toggleTaskCompletion(int index) {
    setState(() {
      int realIndex = tasks.indexOf(filteredTasks[index]);
      tasks[realIndex] = tasks[realIndex] + " ✅";
      _filterTasks();
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
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar tarea...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
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
          // Lista de tareas filtradas
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredTasks[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => toggleTaskCompletion(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTask(index),
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
