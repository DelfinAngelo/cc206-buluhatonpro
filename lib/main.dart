import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final TextEditingController _taskController = TextEditingController();

  
  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.addAll(prefs.getStringList('tasks') ?? []);
      _completedTasks.addAll(prefs.getStringList('completedTasks') ?? []);
    });
  }

  
  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', _tasks);
    prefs.setStringList('completedTasks', _completedTasks);
  }

  // Add a task to the list
  void _addTask(String task) {
    setState(() { 
      _tasks.add(task);
    });
    _saveTasks(); // Save updated tasks
  }

  // Mark a task as completed
  void _markTaskCompleted(int index) {
    setState(() {
      _completedTasks.add(_tasks[index]);
      _tasks.removeAt(index);
    });
    _saveTasks(); // Save updated tasks
  }

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks on app startup
  }

  @override
  void dispose() {
    _taskController.dispose(); // Dispose controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buluhaton Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              // Navigate to Completed Tasks screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTasksScreen(completedTasks: _completedTasks),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
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

class CompletedTasksScreen extends StatelessWidget {
  final List<String> completedTasks;

  const CompletedTasksScreen({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: completedTasks.isEmpty
          ? const Center(
              child: Text('No tasks completed yet!'),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(completedTasks[index]),
                );
              },
            ),
    );
  }
}
