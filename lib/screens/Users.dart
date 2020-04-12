import 'dart:ffi';
import 'package:curve4/models/users.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/products.dart';
import '../utils/dbhelper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
 DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<Users> userList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (userList == null) {
      userList = List<Users>();
      // updateUserListView();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          centerTitle: true,
        ),
        body: getUserListView(),
      ),
    );
  }

  getUserListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                backgroundColor: Colors.white,
              ),
              title: Text('textx',
                // this.productList[position].title,
                style: titleStyle,
              ),
              subtitle: Text('textx',
                // this.productList[position].date,
                style: TextStyle(fontSize: 11),
              ),
              trailing: GestureDetector(
                  // onTap: () => _delete(context, productList[position]),
                  child: Icon(Icons.delete, color: Colors.grey)),
              
            ),
          );
        });
  }
  
}
