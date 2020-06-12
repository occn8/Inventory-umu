import 'package:curve4/models/report_model.dart';
import 'package:curve4/screens/reportadd.dart';
import 'package:curve4/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReportView extends StatefulWidget {
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<ReportModel> reportList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (reportList == null) {
      reportList = List<ReportModel>();
      updateReportListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: getReportListView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToDetail(ReportModel('', ''), 'Write Report');
        },
        label: Text("Add"),
        icon: Icon(Icons.assignment),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 4,
      ),
    );
  }

  getReportListView() {
    TextStyle titleStyle = TextStyle(color: Colors.black);
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Card(
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: Icon(Icons.assignment),
                title: Text(
                  this.reportList[position].writer,
                  style: titleStyle,
                ),
                subtitle: Text(
                  this.reportList[position].date,
                  style: TextStyle(fontSize: 11),
                ),
                trailing: GestureDetector(
                    onTap: () => _delete(context, reportList[position]),
                    child: Icon(Icons.delete, color: Colors.grey)),
                onTap: () {
                  navigateToDetail(this.reportList[position], 'Edit Report');
                },
              ),
            ),
          );
        });
  }

  void _delete(BuildContext context, ReportModel report) async {
    int result = await dataBaseHelper.deleteUser(report.id);
    if (result != 0) {
      updateReportListView();
      final snackBar = SnackBar(content: Text('report removed'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void navigateToDetail(ReportModel report, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReportDetail(title, report);
    }));
    if (result == true) {
      updateReportListView();
    }
  }

  void updateReportListView() {
    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ReportModel>> reportListFuture =
          dataBaseHelper.getReportList();
      reportListFuture.then((reportList) {
        setState(() {
          this.reportList = reportList;
          this.count = reportList.length;
        });
      });
    });
  }
}
