import 'package:flutter/material.dart';

import 'scope/scopes_page.dart';

void main() => runApp(ScopesApp());

class ScopesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scopes',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(secondary: Colors.amber.shade200),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: ScopesPage(),
    );
  }
}
