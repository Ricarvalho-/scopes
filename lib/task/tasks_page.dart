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
          mainAxisAlignment: MainAxisAlignment.end,
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
        onPressed: () => setState(() {
          tasks.add(
            Task("Task ${tasks.length + 1}", TaskStatus.toDo()),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => TaskItem(
          task: tasks[index],
        ),
      ),
    );
  }
}