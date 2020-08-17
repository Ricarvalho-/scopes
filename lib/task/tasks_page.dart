import 'package:flutter/material.dart';

import '../goal/model/goal.dart';
import 'model/task_status.dart';
import 'model/task.dart';
import 'task_item.dart';

class TasksPage extends StatefulWidget {
  final Goal goal;

  TasksPage({Key key, this.goal}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState(goal.tasks);
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks;

  _TasksPageState(this.tasks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goal.title),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Search",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create task',
        child: Icon(Icons.add),
        onPressed: _askForTitle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => TaskItem(
          task: tasks[index],
        ),
      ),
    );
  }

  void _askForTitle() async {
    final title = await showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: Text("New task"),
            content: TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              FlatButton(
                child: Text("CANCEL"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(controller.value.text),
              ),
            ],
          );
        });
    if (title == null || title.toString().trim().isEmpty) return;
    setState(() => tasks.add(
      Task(title, TaskStatus.toDo()),
    ));
  }
}
