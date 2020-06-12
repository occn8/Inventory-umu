import 'package:curve4/screens/Users.dart';
import 'package:curve4/screens/home.dart';
import 'package:curve4/screens/login.dart';
import 'package:curve4/screens/report.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var key = prefs.getString('key');
  print(key);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 153, 0, 0),
        accentColor: Color.fromARGB(255, 128, 50, 0),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/reports': (context) => ReportView(),
        '/users': (context) => UsersView(),
      },
      home: key == null ? LogIn() : InvMgt()));
}