import 'package:flutter/material.dart';

import 'screens/Users.dart';
import 'screens/home.dart';
import 'screens/report.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 153, 0, 0),
        accentColor: Color.fromARGB(255, 128, 50, 0),
        primarySwatch: Colors.blue,
      ),
      home: InvMgt(),
      routes: {
        '/reports': (context) => Report(),
        '/users': (context) => Users(),
      },
    );
  }
}
