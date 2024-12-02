// File: lib/main.dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Buluhaton Pro - Task Manager')),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_tasks[index]),
              );
            },
          ),
        ),
      ],
    ),
  );
}
