import 'package:flutter/material.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Map<String, String>> completedTasks;
  final VoidCallback onClearTasks; // Define the missing parameter

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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onClearTasks, // Use the defined parameter
          ),
        ],
      ),
      body: completedTasks.isEmpty
          ? Center(
              child: Text(
                'No tasks completed yet!',
                style: theme.bodyMedium, // Use bodyMedium for compatibility
              ),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    completedTasks[index]['task']!,
                    style: theme.bodyLarge, // Use bodyLarge for compatibility
                  ),
                  subtitle: Text(
                    'Completed at: ${completedTasks[index]['time']}',
                    style: theme.bodySmall, // Use bodySmall for compatibility
                  ),
                );
              },
            ),
    );
  }
}