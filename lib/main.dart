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
