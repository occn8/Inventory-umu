import 'package:flutter/material.dart';

import 'menuitems.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 260,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFF262AAA),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              ListTile(
                title: Text('Occn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800)),
                subtitle: Text('occnDeveloper.io',
                    style: TextStyle(
                        color: Color(0xFF1885FD),
                        fontSize: 15,
                        fontWeight: FontWeight.w800)),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                  radius: 35,
                ),
              ),
              Divider(
                height: 64,
                thickness: 0.5,
                color: Colors.white.withOpacity(0.5),
                indent: 20,
                endIndent: 20,
              ),
              MenuItem(
                icon: Icons.home,
                title: 'Home',
                ontap: () {},
              ),
              MenuItem(
                icon: Icons.person,
                title: 'Reports',
                ontap: () {},
              ),
              MenuItem(
                icon: Icons.shopping_basket,
                title: 'Users',
                ontap: () {},
              ),
              MenuItem(
                icon: Icons.card_giftcard,
                title: 'Admins',
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