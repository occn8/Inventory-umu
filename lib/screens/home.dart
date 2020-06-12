import 'package:backdrop/backdrop.dart';
import 'package:curve4/widgets/backlayer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/products_model.dart';
import '../utils/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

import 'add.dart';

class InvMgt extends StatefulWidget {
  @override
  _InvMgtState createState() => _InvMgtState();
}

class _InvMgtState extends State<InvMgt> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<ProductsModel> productList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (productList == null) {
      productList = List<ProductsModel>();
      updateListView();
    }

    return SafeArea(
      child: BackdropScaffold(
        headerHeight: 120,
        appBar: BackdropAppBar(
          title: Text("Inventory"),
          centerTitle: true,
          // actions: <Widget>[
          //   BackdropToggleButton(
          //     icon: AnimatedIcons.list_view,
          //   )
          // ],
        ),
        backLayer:BackLay(),
        frontLayer: getNoteListView(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToDetail(ProductsModel('', '', 2, ''), 'Add Item');
          },
          label: Text("Add"),
          icon: Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 4,
        ),
      ),
    );
  }

  getNoteListView() {
    TextStyle titleStyle = TextStyle(color: Colors.black);
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                child: getPriorityIcon(this.productList[position].priority),
                backgroundColor:
                    getPriorityColor(this.productList[position].priority),
              ),
              title: Text(
                this.productList[position].title,
                style: titleStyle,
              ),
              subtitle: Text(
                this.productList[position].barcode,
                style: TextStyle(fontSize: 11),
              ),
              trailing: GestureDetector(
                  onTap: () => _delete(context, productList[position]),
                  child: Icon(Icons.delete, color: Colors.grey)),
              onTap: () {
                navigateToDetail(this.productList[position], 'Edit Item');
              },
            ),
          );
        });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.orange;
        break;
      default:
        return Colors.orange;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.assignment_turned_in);
        break;
      case 2:
        return Icon(Icons.build);
        break;
      default:
        return Icon(Icons.build);
    }
  }

  void _delete(BuildContext context, ProductsModel note) async {
    int result = await dataBaseHelper.deleteNote(note.id);
    if (result != 0) {
      // _showSnackBar(context, 'Item deleted successfully');
      updateListView();
      final snackBar = SnackBar(content: Text('Item deleted successfully'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  // Void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }

  void navigateToDetail(ProductsModel note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InvDetails(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> DbFuture = dataBaseHelper.initializeDatabase();
    DbFuture.then((database) {
      Future<List<ProductsModel>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.productList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
