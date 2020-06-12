import 'package:flutter/material.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),centerTitle: true,
      ),
      body: Container(
        child: Text('Report'),
      ),
    );
  }
}
