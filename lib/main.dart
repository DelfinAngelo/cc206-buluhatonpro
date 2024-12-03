import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        fontFamily: 'Poppins', // Set global font
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black), // Replaced bodyText1 with bodyLarge
          bodyMedium: TextStyle(fontSize: 16), // Replaced bodyText2 with bodyMedium
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

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  void _markTaskCompleted(int index) {
    final String currentTime = DateFormat('hh:mm a').format(DateTime.now());
    setState(() {
      _completedTasks.add({'task': _tasks[index], 'time': currentTime});
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buluhaton Pro - Task Manager'),
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
                style: theme.bodyLarge?.copyWith(fontFamily: 'Poppins'), // Replaced bodyText1 with bodyLarge
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
                      style: theme.bodyLarge, // Replaced bodyText1 with bodyLarge
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
