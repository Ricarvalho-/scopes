import 'package:flutter/material.dart';
import 'package:scopes/task/model/task_status.dart';

import 'model/task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  TaskItem({Key key, this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      subtitle: Column(
        children: [
          Text("Status: ${_status()}"),
          if (_isDoing()) Text("Progress: ${widget.task.progress()}"),
          _actions()
        ],
      ),
    );
  }

  String _status() {
    switch (widget.task.status.status) {
      case Status.toDo: return "To Do";
      case Status.doing: return "Doing";
      case Status.done: return "Done";
      default: return "";
    }
  }

  bool _isDoing() => widget.task.status.isSameAs(Status.doing);

  Widget _actions() {
    switch (widget.task.status.status) {
      case Status.toDo: return RaisedButton(
        child: Text("Begin"),
        onPressed: () => setState(() {
          widget.task.status = TaskStatus.doing(0);
        }),
      );
      case Status.doing: return Row(
        children: [
          FlatButton(
            child: Text("Cancel"),
            onPressed: () => setState(() {
              widget.task.status = TaskStatus.toDo();
            }),
          ),
          RaisedButton(
            child: Text("Finish"),
            onPressed: () => setState(() {
              widget.task.status = TaskStatus.done();
            }),
          ),
        ],
      );
      case Status.done: return RaisedButton(
        child: Text("Restart"),
        onPressed: () => setState(() {
          widget.task.status = TaskStatus.toDo();
        }),
      );
      default: return null;
    }
  }
}