import 'package:flutter/material.dart';

import 'menuitems.dart';

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
            leading: CircleAvatar(backgroundColor: Colors.white,
              child: Icon(
                Icons.person,size: 34,
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
          MenuItem(
            icon: Icons.home,
            title: 'Home',
            ontap: () {
              Navigator.pop(context);
            },
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
          MenuItem(
            icon: Icons.exit_to_app,
            title: 'Log Out',
          ),
        ],
      ),
    );
  }
}
