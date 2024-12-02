TextField(
  controller: _taskController,
  decoration: InputDecoration(
    labelText: 'Enter a task',
    border: OutlineInputBorder(),
  ),
),
ElevatedButton(
  onPressed: () {
    if (_taskController.text.isNotEmpty) {
      _addTask(_taskController.text);
      _taskController.clear();
    }
  },
  child: Text('Add Task'),
),
