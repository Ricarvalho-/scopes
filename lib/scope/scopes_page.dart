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
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            tooltip: "About",
            onPressed: () => showAboutScopesDialog(context: context),
          ),
        ],
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
        tooltip: 'Create scope',
        child: Icon(Icons.add),
        onPressed: _askForTitle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
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

  void _askForTitle() async {
    final title = await showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: Text("New scope"),
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
    setState(() => scopes.add(
      Scope(title, []),
    ));
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