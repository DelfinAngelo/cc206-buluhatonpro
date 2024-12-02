// File: lib/main.dart
void _addTask(String task) {
  setState(() {
    _tasks.add(task);
  });
}

void _markTaskCompleted(int index) {
  setState(() {
    _completedTasks.add(_tasks[index]);
    _tasks.removeAt(index);
  });
}
