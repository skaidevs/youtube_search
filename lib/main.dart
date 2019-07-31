import 'package:flutter/material.dart';

import 'injection_container.dart';
import 'ui/search/search_page.dart';

void main() {
  initKiwi();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red.shade600,
          accentColor: Colors.redAccent.shade400,
          cursorColor: Colors.redAccent.shade700),
      home: SearchPage(),
    );
  }
}
