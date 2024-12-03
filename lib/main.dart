// File: lib/completed_tasks_screen.dart
import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Map<String, String>> completedTasks;
  final VoidCallback onClearTasks;

  const CompletedTasksScreen({
    super.key,
    required this.completedTasks,
    required this.onClearTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onClearTasks,
          ),
        ],
      ),
      body: completedTasks.isEmpty
          ? const Center(child: Text('No tasks completed yet!'))
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(completedTasks[index]['task']!),
                  subtitle: Text('Completed at: ${completedTasks[index]['time']}'),
                );
              },
            ),
    );
  }
}

// File: lib/main.dart
void _markTaskCompleted(int index) {
  final String currentTime = DateFormat('hh:mm a').format(DateTime.now());
  setState(() {
    _completedTasks.add({'task': _tasks[index], 'time': currentTime});
    _tasks.removeAt(index);
  });
  _saveTasks();
}

void _clearCompletedTasks() {
  setState(() {
    _completedTasks.clear();
  });
  _saveTasks();
}
