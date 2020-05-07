import '../models/users.dart';
import 'package:flutter/material.dart';
import '../utils/dbhelper.dart';

class UserDetails extends StatefulWidget {
  final String appBarTitle;
  final Users user;
  UserDetails(this.user, this.appBarTitle);
  @override
  _UserDetailsState createState() =>
      _UserDetailsState(this.appBarTitle, this.user);
}

class _UserDetailsState extends State<UserDetails> {
  DataBaseHelper helper2 = DataBaseHelper();

  String appBarTitle;
  Users user;
  _UserDetailsState(this.appBarTitle, this.user);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    nameController.text = user.name;
    passwordController.text = user.password;
    
// return WillPopScope(
//       onWillPop: () {
//         moveToLastScreen();
//       },

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: nameController,
                  style: textStyle,
                  onChanged: (value) {
                    updateName();
                  },
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: textStyle,
                  onChanged: (value) {
                    updatePassword();
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _save();
                                print(passwordController);
                              });
                            }),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                moveToLastScreen();
                              });
                            }),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateName() {
    user.name = nameController.text;
  }

  void updatePassword() {
    user.password = passwordController.text;
  }

  void _save() async {
    moveToLastScreen();
    int result;
    if (user.id != null) {
      result = await helper2.updateUser(user);
    } else {
      result = await helper2.insertUser(user);
    }
    if (result != 0) {
      _showSnackBar(context, 'Saved successfully');
    } else {
      _showSnackBar(context, 'problem saveing');
    }
  }

  _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // void _delete() async {
  //   moveToLastScreen();

  //   if (user.id != null) {
  //     _showAlartDialog('status', 'no product  deleted');
  //     return;
  //   }
  //   int result = await helper2.deleteNote(user.id);
  //   if (result != 0) {
  //     _showAlartDialog('status', 'product deleted successfully');
  //   } else {
  //     _showAlartDialog('status', 'Error occured deleting product');
  //   }
  // }

  // void _showAlartDialog(String title, String message) {
  //   AlertDialog alartDialog = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alartDialog);
  // }
}
