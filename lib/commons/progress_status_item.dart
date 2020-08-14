import 'package:flutter/material.dart';
import 'package:scopes/commons/progress_status.dart';

class ProgressStatusItem extends StatelessWidget {
  final ProgressStatus status;
  final Function onTap;

  ProgressStatusItem({
    Key key,
    this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(status.title),
      subtitle: Column(
        children: [
          Text("Deadline: ${status.highlightedDeadline()}"),
          Text("To Do: ${status.toDoPercent()}"),
          Text("Doing: ${status.doingPercent()}"),
          Text("Done: ${status.donePercent()}"),
        ],
      ),
      onTap: onTap,
    );
  }
}