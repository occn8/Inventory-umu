import 'package:curve4/widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'Users.dart';
import 'admins.dart';
import 'barcode.dart';
import 'invmgt.dart';
import 'report.dart';
import 'settings.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Center(
                    child: Text('Umu Inventory',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.w400))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 10),
                child: Center(
                    child: Text(
                        'Uganda Martyrs University Inventory Management System',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonLink(
                      text: 'Reports',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Report()));
                      },
                    ),
                    ButtonLink(
                      text: 'inventory',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => InvMgt()));
                      },
                    ),
                    ButtonLink(
                      text: 'Scan',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => BarCode()));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonLink(
                      text: 'Admins',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Admins()));
                      },
                    ),
                    ButtonLink(
                      text: 'Users',
                      ontap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Users()));
                      },
                    ),
                    ButtonLink(
                      text: 'Settings',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//inventory
