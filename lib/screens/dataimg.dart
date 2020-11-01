import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newlog/screens/home.dart';
import 'package:newlog/screens/login.dart';

class Dataimgg extends StatefulWidget {
  @override
  _DataimggState createState() => _DataimggState();
}

class _DataimggState extends State<Dataimgg> {
  final database = FirebaseDatabase.instance.reference();
  Login login;
  Home home;
  String note;
  DateTime date = DateTime.now();
  var formatter = DateFormat.yMd();

  @override
  void initState() {
    super.initState();
    dataa();
  }

  Text dataa() {
    return Text('${formatter.format(date)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('บันทึกโน้ต'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[dataa(), Text(''), userForm(), sevee()],
            ),
          ),
        ));
  }

  Widget sevee() => Container(
        width: 150.0,
        child: RaisedButton(
          color: Colors.green,
          onPressed: () {
            show();
          },
          child: Text(
            'บันทึก',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  final movieName = 'MovieTitle', datee = 'Date';

  Future<Null> show() async {
    var data = database.child("user");
    data
        .child(user)
        .child('note')
        .push()
        .set({'$movieName': note, '$datee': dataa()}).asStream();
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home());
    Navigator.push(context, route);
  }

  Widget userForm() => Container(
        width: 300.0,
        height: 100.0,
        child: TextField(
          onChanged: (value) => note = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.add_to_photos,
                color: Colors.black,
              ),
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'โน้ต',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent))),
        ),
      );
}
