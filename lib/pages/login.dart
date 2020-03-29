import 'package:flutter/material.dart';
import './signup.dart';
import '../widgets/clippath.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String name;
  String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,153, 0, 0),
                ),
              ),
              clipper: CustomClipPath(),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 100.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //SUMTING
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      )),
                                      filled: true,
                                      // icon: Icon(Icons.person, color: Colors.red),
                                      fillColor: Colors.grey[700],
                                      hintText: 'your name',
                                      labelText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Name is required';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.name = value;
                                  },
                                ),
                                SizedBox(height: 30.0),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    // icon: Icon(Icons.person, color: Colors.red),
                                    fillColor: Colors.grey[700],
                                    hintText: 'your Password',
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.password = value;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                RaisedButton(
                                  color: Colors.blueGrey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    _formKey.currentState.save();
                                    print('logged in');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()),
                                    );
                                  },
                                  child: Text('Login',style: TextStyle(color: Colors.white),),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Don\'t have an Account? ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700]),
                                    ),
                                    // SizedBox(width: 4),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignUp()),
                                          );
                                        },
                                        child: Text(
                                          'sign up',
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
