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
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onClearTasks(); // Trigger the callback
              Navigator.pop(context); // Return to TaskManager
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: completedTasks.isEmpty
            ? Center(
                child: Text(
                  'No tasks completed yet!',
                  style: theme.bodyMedium,
                ),
              )
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      completedTasks[index]['task']!,
                      style: theme.bodyLarge,
                    ),
                    subtitle: Text(
                      'Completed at: ${completedTasks[index]['time']}',
                      style: theme.bodySmall,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
