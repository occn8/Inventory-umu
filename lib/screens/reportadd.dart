import 'package:curve4/models/report_model.dart';
import 'package:curve4/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportDetail extends StatefulWidget {
  final String appBarTitle;
  final ReportModel report;
  ReportDetail(this.appBarTitle, this.report);

  @override
  _ReportDetailState createState() =>
      _ReportDetailState(this.appBarTitle, this.report);
}

class _ReportDetailState extends State<ReportDetail> {
  DataBaseHelper helper2 = DataBaseHelper();
  final String appBarTitle;
  final ReportModel report;

  _ReportDetailState(this.appBarTitle, this.report);
  TextEditingController writerController = TextEditingController();
  TextEditingController reportTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.black);
    writerController.text = report.writer;
    reportTxtController.text = report.reportTxt;

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
                  controller: writerController,
                  style: textStyle,
                  onChanged: (value) {
                    updateWriter();
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
                  maxLines: 10,
                  controller: reportTxtController,
                  style: textStyle,
                  onChanged: (value) {
                    updateRportTxt();
                  },
                  decoration: InputDecoration(
                    labelText: 'Report',
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
                                print(writerController);
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

  void updateWriter() {
    report.writer = writerController.text;
  }

  void updateRportTxt() {
    report.reportTxt = reportTxtController.text;
  }

  void _save() async {
    moveToLastScreen();
    report.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (report.id != null) {
      result = await helper2.updateReport(report);
    } else {
      result = await helper2.insertReport(report);
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
}
