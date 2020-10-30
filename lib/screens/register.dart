import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newlog/screens/login.dart';
import 'package:newlog/uti/dialog.dart';
import 'package:newlog/uti/mystyle.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, password, name;
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/3.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showText('ลงทะเบียน'),
                MyStyle().showText(''),
                userForm(),
                MyStyle().mySizebox(),
                passForm(),
                MyStyle().mySizebox(),
                nameFrom(),
                MyStyle().mySizebox(),
                register(),
                back(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget register() => Container(
      width: 100.0,
      child: RaisedButton(
        color: Colors.green,
        onPressed: () {
          if (username == null ||
              username.isEmpty ||
              password == null ||
              password.isEmpty ||
              name == null ||
              name.isEmpty) {
            normalDialog(context, 'กรุณากรอกข้อมูล');
          } else {
            var root = database.child("user");
            root.child(username).once().then((DataSnapshot snapshot) {
              if ('${snapshot.value}' == 'null') {
                regis();
              } else {
                normalDialog(context, 'มีข้อมูลแล้ว');
              }
            });
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Future<Null> regis() async {
    var root = database.child("user");
    root.child(username).set({
      'name': name,
      'Password': password,
    });
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Login(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget back() => Container(
      width: 100.0,
      child: RaisedButton(
        color: Colors.red,
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Login(),
          );
          Navigator.push(context, route);
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Username',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );

  Widget nameFrom() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.white,
              ),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Name',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );

  Widget passForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );
}
