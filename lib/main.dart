final theme = Theme.of(context).textTheme;

body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextField(
        controller: _taskController,
        decoration: const InputDecoration(
          labelText: 'Enter a task',
          border: OutlineInputBorder(),
        ),
        style: theme.bodyText1?.copyWith(fontFamily: 'Consolas'),
      ),
      ...
    ],
  ),
);
