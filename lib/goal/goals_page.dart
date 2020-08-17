import 'package:flutter/material.dart';

import '../commons/extensions.dart';
import '../commons/holder.dart';
import '../commons/progress_status_item.dart';
import '../scope/model/scope.dart';
import '../task/tasks_page.dart';
import 'model/goal.dart';

class GoalsPage extends StatefulWidget {
  final Scope scope;

  GoalsPage({Key key, this.scope}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState(scope.goals);
}

class _GoalsPageState extends State<GoalsPage> {
  List<Goal> goals;

  _GoalsPageState(this.goals);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scope.title),
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
        tooltip: 'Create goal',
        child: Icon(Icons.add),
        onPressed: _askForTitle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
      body: ListView.separated(
        itemCount: goals.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ProgressStatusItem(
          status: goals[index],
          onTap: () => _navigateTo(goals[index]),
        ),
      ),
    );
  }

  void _askForTitle() async {
    final deadline = Holder<DateTime>();
    final title = await showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: Text("New goal"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8,),
                DeadlineSelector(
                  deadline: deadline,
                ),
              ],
            ),
            actions: [
              FlatButton(
                child: Text("CANCEL"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () =>
                    Navigator.of(context).pop(controller.value.text),
              ),
            ],
          );
        });
    if (title == null || title.toString().trim().isEmpty) return;
    setState(() => goals.add(
          Goal(title, deadline.value, []),
        ));
  }

  void _navigateTo(Goal goal) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TasksPage(
        goal: goal,
      ),
    ));
    setState(() {});
  }
}

class DeadlineSelector extends StatefulWidget {
  final Holder<DateTime> deadline;

  DeadlineSelector({Key key, this.deadline}) : super(key: key);

  @override
  _DeadlineSelectorState createState() => _DeadlineSelectorState(deadline);
}

class _DeadlineSelectorState extends State<DeadlineSelector> {
  final Holder<DateTime> deadline;

  _DeadlineSelectorState(this.deadline);

  @override
  Widget build(BuildContext context) => FlatButton.icon(
        icon: Icon(deadline.value == null ? Icons.alarm_add : Icons.alarm),
        label: Text(deadline.value?.prettyFormatted() ?? "Add deadline"),
        onPressed: _askForDeadline,
      );

  void _askForDeadline() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: deadline.value ?? DateTime.now(),
      firstDate: DateTime(-271820),
      lastDate: DateTime(275760),
    );
    if (dateTime == null) return;
    setState(() => deadline.value = dateTime);
  }
}
