import 'package:curve4/screens/login.dart';
import 'package:curve4/utilities/menuitems.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text('UMU Inventory',
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
          Divider(
            height: 64,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            title: Text('Kobbi',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800)),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 34,
                color: Colors.blue,
              ),
              radius: 35,
            ),
          ),
          Divider(
            height: 40,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
            ontap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/reports');
            },
          ),
          MenuItem(
            icon: Icons.person,
            title: 'Users',
            ontap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/users');
            },
          ),
          MenuItem(
            icon: Icons.settings,
            title: 'Settings',
          ),
          Divider(
            height: 40,
            thickness: 0.5,
            color: Colors.white.withOpacity(0.5),
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
