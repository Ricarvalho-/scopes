import 'package:flutter/material.dart';

import '../commons/about.dart';
import '../commons/progress_status_item.dart';
import '../goal/goals_page.dart';
import 'model/scope.dart';

class ScopesPage extends StatefulWidget {
  @override
  _ScopesPageState createState() => _ScopesPageState();
}

class _ScopesPageState extends State<ScopesPage> {
  List<Scope> scopes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scopes"),
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
            IconButton(
              icon: Icon(Icons.info_outline),
              tooltip: "About",
              onPressed: () => showAboutScopesDialog(context: context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create scope',
        child: Icon(Icons.add),
        onPressed: () => setState(() {
          scopes.add(
              Scope("Scope ${scopes.length + 1}", []),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.separated(
        itemCount: scopes.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ProgressStatusItem(
          status: scopes[index],
          onTap: () => _navigateTo(scopes[index]),
        ),
      ),
    );
  }

  void _navigateTo(Scope scope) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => GoalsPage(
        scope: scope,
      ),
    ));
    setState(() {});
  }
}