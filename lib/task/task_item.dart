import 'package:flutter/material.dart';

import '../commons/extensions.dart';
import 'model/task_status.dart';
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
      subtitle: _content(),
    );
  }

  String _status() {
    switch (widget.task.status.status) {
      case Status.toDo:
        return "To Do";
      case Status.doing:
        return "Doing";
      case Status.done:
        return "Done";
      default:
        return "";
    }
  }

  Widget _content() {
    switch (widget.task.status.status) {
      case Status.toDo:
      case Status.done:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_status()),
            _actions(),
          ],
        );
      case Status.doing:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_status()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slider.adaptive(
                      value: widget.task.progress,
                      onChanged: (value) => setState(() {
                        widget.task.status = TaskStatus.doing(value);
                      }),
                    ),
                  ),
                ),
                Text(widget.task.progress.toStringAsPercent()),
              ],
            ),
            _actions(),
          ],
        );
      default:
        return null;
    }
  }

  Widget _actions() {
    switch (widget.task.status.status) {
      case Status.toDo:
        return RaisedButton(
          child: Text("BEGIN"),
          onPressed: () => setState(() {
            widget.task.status = TaskStatus.doing(0);
          }),
        );
      case Status.doing:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton(
              child: Text("CANCEL"),
              onPressed: () => setState(() {
                widget.task.status = TaskStatus.toDo();
              }),
            ),
            RaisedButton(
              child: Text("FINISH"),
              onPressed: () => setState(() {
                widget.task.status = TaskStatus.done();
              }),
            ),
          ],
        );
      case Status.done:
        return RaisedButton(
          child: Text("RESTART"),
          onPressed: () => setState(() {
            widget.task.status = TaskStatus.toDo();
          }),
        );
      default:
        return null;
    }
  }
}
