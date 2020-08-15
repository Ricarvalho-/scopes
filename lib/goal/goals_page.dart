import 'package:flutter/material.dart';

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
        tooltip: 'Create goal',
        child: Icon(Icons.add),
        onPressed: () => setState(() {
          goals.add(
            Goal("Goal ${goals.length + 1}", DateTime.now(), []),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  void _navigateTo(Goal goal) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TasksPage(
        goal: goal,
      ),
    ));
    setState(() {});
  }
}