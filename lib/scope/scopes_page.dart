import 'package:flutter/material.dart';

class ScopesPage extends StatefulWidget {
  @override
  _ScopesPageState createState() => _ScopesPageState();
}

class _ScopesPageState extends State<ScopesPage> {
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
              icon: Icon(Icons.more_vert),
              tooltip: "More",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create scope',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}