import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

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
