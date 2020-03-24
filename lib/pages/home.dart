import 'package:flutter/material.dart';

import 'barcode.dart';
import 'invmgt.dart';
import 'report.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:8.0,bottom: 8),
                child: Center(child: Text('Umu Inventory',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.grey[400],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Report()));
                        },
                        child: Text('Report'),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.yellowAccent,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>InvMgt()));
                        },
                        child: Text('inventory mgt'),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.grey[400],
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BarCode()));
                        },
                        child: Text('Scan'),
                      ),
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
