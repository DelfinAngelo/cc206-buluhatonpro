// File: lib/main.dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CompletedTasksScreen(completedTasks: _completedTasks),
  ),
);
