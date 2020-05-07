import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/dbhelper.dart';
import '../models/users.dart';
import 'dart:async';

import 'useradd.dart';

class UsersP extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<UsersP> {
  DataBaseHelper dataBaseHelper2 = DataBaseHelper();
  List<Users> userList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (userList == null) {
      userList = List<Users>();
      updateUserListView();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          centerTitle: true,
        ),
        body: getUserListView(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToDetail(Users('', ''), 'Add user');
          },
          label: Text("Add"),
          icon: Icon(Icons.person_add),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 4,
        ),
      ),
    );
  }

  getUserListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          // if(position.isOdd)return Divider();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Icon(Icons.person,
                      color: Theme.of(context).primaryColor, size: 25),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        blurRadius: 4.0,
                        offset: Offset(0.0, 4.0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: <Widget>[
                          Text(this.userList[position].name, style: titleStyle),
                          // Text(this.userList[position].password,
                          //     style: TextStyle(fontSize: 11)),
                          Row(
                            children: <Widget>[
                              Icon(Icons.more_horiz),
                              Icon(Icons.more_horiz),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: GestureDetector(
                            onTap: () => _delete(context, userList[position]),
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return Card(
          //   color: Colors.white,
          //   elevation: 2,
          //   child: ListTile(
          //     leading: CircleAvatar(
          //       child: Icon(
          //         Icons.person,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //       backgroundColor: Colors.white,
          //     ),
          //     title: Text(
          //       this.userList[position].name,
          //       style: titleStyle,
          //     ),
          //     subtitle: Text(
          //       this.userList[position].password,
          //       style: TextStyle(fontSize: 11),
          //     ),
          //     trailing: GestureDetector(
          //         onTap: () => _delete(context, userList[position]),
          //         child: Icon(Icons.delete, color: Colors.grey)),
          //   ),
          // );
        });
  }

  void _delete(BuildContext context, Users user) async {
    int result = await dataBaseHelper2.deleteUser(user.id);
    if (result != 0) {
      // _showSnackBar(context, 'user removed');
      updateUserListView();
       final snackBar = SnackBar(content: Text('user removed'));
    Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  // Void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  void navigateToDetail(Users user, String name) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserDetails(user, name);
    }));
    if (result == true) {
      updateUserListView();
    }
  }

  void updateUserListView() {
    final Future<Database> DbFuture = dataBaseHelper2.initializeDatabase();
    DbFuture.then((database) {
      Future<List<Users>> userListFuture = dataBaseHelper2.getUserList();
      userListFuture.then((userList) {
        setState(() {
          this.userList = userList;
          this.count = userList.length;
        });
      });
    });
  }
}
