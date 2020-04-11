import 'package:curve4/widgets/buttons.dart';
import 'package:curve4/widgets/mydrawer.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // body: InvMgt(),
        drawer: MyDrawer()
      ),
    );
  }
}

//inventory
