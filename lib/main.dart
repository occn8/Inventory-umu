import 'package:curve4/screens/Users.dart';
import 'package:curve4/screens/home.dart';
import 'package:curve4/screens/login.dart';
import 'package:curve4/screens/report.dart';
import 'package:flutter/material.dart';

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
        '/users': (context) => UsersP(),
      },
    );
  }
}
