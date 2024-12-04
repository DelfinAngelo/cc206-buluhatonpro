import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'completed_tasks_screen.dart';
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
      theme: ThemeData(
        fontFamily: 'Consolas',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const TaskManager(),
    );
  }
}

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  final List<String> _tasks = [];
  final List<Map<String, String>> _completedTasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.addAll(prefs.getStringList('tasks') ?? []);
      final completedList = prefs.getStringList('completedTasks') ?? [];
      _completedTasks.clear();
      _completedTasks.addAll(completedList.map((task) {
        final taskParts = task.split('|');
        return {'task': taskParts[0], 'time': taskParts[1]};
      }).toList());
    });
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', _tasks);
    prefs.setStringList('completedTasks', _completedTasks
        .map((task) => '${task['task']}|${task['time']}')
        .toList());
  }

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _saveTasks();  // Save tasks after adding
  }

  void _markTaskCompleted(int index) {
    final String currentTime = DateFormat('hh:mm a').format(DateTime.now());
    setState(() {
      _completedTasks.add({'task': _tasks[index], 'time': currentTime});
      _tasks.removeAt(index);
    });
    _saveTasks();  // Save tasks after marking completed
  }

  void _clearCompletedTasks() {
    setState(() {
      _completedTasks.clear();
    });
    _saveTasks();  // Save tasks after clearing completed tasks
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buluhaton Pro - Task Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.list_alt),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompletedTasksScreen(
                completedTasks: _completedTasks,
                onClearTasks: _clearCompletedTasks,
              ),
            ),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: 'Enter a task',
                  border: OutlineInputBorder(),
                ),
                style: theme.bodyLarge?.copyWith(fontFamily: 'Consolas'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  _addTask(_taskController.text);
                  _taskController.clear();
                }
              },
              child: const Text('Add Task'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _tasks[index],
                      style: theme.bodyLarge,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => _markTaskCompleted(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
