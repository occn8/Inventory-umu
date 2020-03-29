import 'package:flutter/material.dart';
import '../widgets/clippath.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name;
  String email;
  String phone;
  String password;
  String password2;

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                ),
              ),
              clipper: CustomClipPath(),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            SizedBox(width: 5),
                            Text('Back'),
                          ],
                        )),
                    SizedBox(height: 10),
                    Text(
                      'Sign up Now',
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
                            key: _formKey2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
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
                                SizedBox(height: 10.0),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLength: 10,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,

                                      // icon: Icon(Icons.person, color: Colors.red),
                                      fillColor: Colors.grey[700],
                                      hintText: 'your Password',
                                      labelText: 'PassWord',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.password = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLength: 10,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      // icon: Icon(Icons.person, color: Colors.red),
                                      fillColor: Colors.grey[700],
                                      hintText: 'confirm Password',
                                      labelText: 're-PassWord',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value == password) {
                                      return 'Password doesn\'t match';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.password2 = value;
                                  },
                                ),
                                SizedBox(height: 10.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      // icon: Icon(Icons.phone, color: Colors.red),
                                      fillColor: Colors.grey[700],
                                      hintText: 'your number',
                                      labelText: 'Phone Number',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      prefixText: '+256 '),
                                  keyboardType: TextInputType.phone,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Phone is required';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.phone = value;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    // icon: Icon(Icons.email, color: Colors.red),
                                    fillColor: Colors.grey[700],
                                    hintText: 'your email address',
                                    labelText: 'E-mail',
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please enter correct email';
                                    }
                                  },
                                  onSaved: (String value) {
                                    this.email = value;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                RaisedButton(
                                  color: Color.fromARGB(255, 0, 77, 128),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  onPressed: () {
                                    if (!_formKey2.currentState.validate()) {
                                      return;
                                    }
                                    _formKey2.currentState.save();
                                    print('registered');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage()),
                                    );
                                  },
                                  child: Text('Sign up'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
