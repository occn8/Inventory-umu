import 'dart:async';

import 'package:backdrop/backdrop.dart';
import 'package:curve4/screens/login.dart';
import 'package:curve4/utilities/menuitems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('name');
  return name;
}

class BackLay extends StatefulWidget {
  @override
  _BackLayState createState() => _BackLayState();
}

class _BackLayState extends State<BackLay> {
  String _name = "";

  @override
  void initState() {
    getName().then(updateName);
    super.initState();
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          ListTile(
            title: Text(_name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.blue,
              ),
              radius: 28,
            ),
          ),
          Divider(
            height: 40,
            thickness: 0.5,
            color: Colors.white60,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            child: GestureDetector(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home, color: Colors.black, size: 25),
                    SizedBox(width: 20),
                    Text(
                      'Home',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          MenuItem(
            icon: Icons.rate_review,
            title: 'Reports',
            ontap: () {Backdrop.of(context).fling();
              // Navigator.pop(context);
              Navigator.pushNamed(context, '/reports');
            },
          ),
          MenuItem(
            icon: Icons.person,
            title: 'Users',
            ontap: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, '/users');
            },
          ),
          Divider(
            height: 30,
            thickness: 0.5,
            color: Colors.white60,
            indent: 20,
            endIndent: 20,
          ),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('key');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => LogIn()));
              print('logedout..');
            },
            child: MenuItem(
              icon: Icons.exit_to_app,
              title: 'Log Out',
            ),
          ),
        ],
      ),
    );
  }
}
