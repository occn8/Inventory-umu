import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import '../models/products.dart';
import '../utils/dbhelper.dart';

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
  TextEditingController reportController = TextEditingController();
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    titleController.text = product.title;
    descriptionController.text = product.description;
    barcode = product.barcode;

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
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
          child: ListView(
            children: <Widget>[
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  maxLines: 4,
                  controller: reportController,
                  style: textStyle,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Report',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              ListTile(
                leading: Text(
                  'Item Status: ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
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
                        updatePriorityAsInt(valueSelectedByUser);
                      });
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Code: ' + barcode ?? null,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      scanBarcodeNormal();
                    },
                    child: Text(
                      'Scan Item',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  )),
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
                              setState(() async {
                                // _save();
                                moveToLastScreen();
                                product.date =
                                    DateFormat.yMMMd().format(DateTime.now());
                                int result;
                                if (product.id != null) {
                                  result = await helper.updateNote(product);
                                } else {
                                  result = await helper.insertNote(product);
                                }
                                if (result != 0) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Saved successfully')));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('problem saveing')));
                                }
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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Null';
    }
    if (!mounted) return;

    setState(() {
      barcode = barcodeScanRes;
    });
    updateBarcode();
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

  void updateBarcode() {
    product.barCode = barcode;
  }

  // void _save() async {
  //   moveToLastScreen();
  //   product.date = DateFormat.yMMMd().format(DateTime.now());
  //   int result;
  //   if (product.id != null) {
  //     result = await helper.updateNote(product);
  //   } else {
  //     result = await helper.insertNote(product);
  //   }
  //   if (result != 0) {
  //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('message')));
  //     _showSnackBar(context, 'Saved successfully');
  //   } else {
  //     _showSnackBar(context, 'problem saveing');
  //   }
  // }

  // _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  // void _delete() async {
  //   moveToLastScreen();

  //   if (product.id != null) {
  //     _showAlartDialog('status', 'no product  deleted');
  //     return;
  //   }
  //   int result = await helper.deleteNote(product.id);
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
