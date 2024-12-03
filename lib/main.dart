// File: lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buluhaton Pro - Task Manager',
      home: TaskManager(),
    );
  }
}

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List<String> _tasks = [];
  final List<String> _completedTasks = [];
  final TextEditingController _taskController = TextEditingController(); // Add controller

  // Add a task to the list
  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  // Mark a task as completed
  void _markTaskCompleted(int index) {
    setState(() {
      _completedTasks.add(_tasks[index]);
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buluhaton Pro - Task Manager')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController, // Use the controller here
                    decoration: const InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                      _taskController.clear();
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      _markTaskCompleted(index);
                    },
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
