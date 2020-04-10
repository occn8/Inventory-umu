import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/products.dart';
import '../utils/dbhelper.dart';
// import 'dart:async';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

class InvDetails extends StatefulWidget {
  final String appBarTitle;
  final Products note;
  InvDetails(this.note, this.appBarTitle);
  @override
  _InvDetailsState createState() =>
      _InvDetailsState(this.appBarTitle, this.note);
}

class _InvDetailsState extends State<InvDetails> {
  DataBaseHelper helper = DataBaseHelper();

  String appBarTitle;
  Products product;
  _InvDetailsState(this.appBarTitle, this.product);

  static var _priorities = ['Good', 'Maintainance'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    titleController.text = product.title;
    descriptionController.text = product.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text(appBarTitle)),
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
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          child: Text(dropDownStringItem),
                          value: dropDownStringItem,
                        );
                      }).toList(),
                      style: textStyle,
                      value: getPriorityAsString(product.priority),
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          print(valueSelectedByUser);
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    maxLines: 4,
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: RaisedButton(
                      onPressed: (){},
                      child: Text(
                        'Scan Product',
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Save',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _save();
                                });
                              }),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Delete',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _delete();
                                });
                              }),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Good':
        product.priority = 1;
        break;
      case 'Maintainance':
        product.priority = 2;
        break;
    }
  }

  getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    product.title = titleController.text;
  }

  void updateDescription() {
    product.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();
    product.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (product.id != null) {
      result = await helper.updateNote(product);
    } else {
      result = await helper.insertNote(product);
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

  void _delete() async {
    moveToLastScreen();

    if (product.id != null) {
      _showAlartDialog('status', 'no product  deleted');
      return;
    }
    int result = await helper.deleteNote(product.id);
    if (result != 0) {
      _showAlartDialog('status', 'product deleted successfully');
    } else {
      _showAlartDialog('status', 'Error occured deleting product');
    }
  }

  void _showAlartDialog(String title, String message) {
    AlertDialog alartDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alartDialog);
  }
}


//scanner

class BarCode extends StatefulWidget {
  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  String barcode = "";

  // @override
  // initState() {
  //   super.initState();
  // }

  // Future scan() async {
  //   try {
  //     String barcode = await BarcodeScanner.scan();
  //     setState(() => this.barcode = barcode);
  //   } on PlatformException catch (e) {
  //     if (e.code == BarcodeScanner.CameraAccessDenied) {
  //       setState(() {
  //         this.barcode = 'Camera permission not granted!';
  //       });
  //     } else {
  //       setState(() => this.barcode = 'Unknown error: $e');
  //     }
  //   } on FormatException {
  //     setState(() => this.barcode =
  //         'null ("back"-button pressed before scanning. Result)');
  //   } catch (e) {
  //     setState(() => this.barcode = 'Unknown error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('bar code'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // scan();
        },
        label: Text("Scan"),
        icon: Icon(Icons.camera_alt),
      ),
    );
  }
}
