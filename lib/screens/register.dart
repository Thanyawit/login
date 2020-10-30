import 'package:flutter/material.dart';
import 'package:newlog/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              children: <Widget>[back()],
            ),
          ),
        ),
      ),
    );
  }
  Widget back() => Container(
      width: 250.0,
      child: RaisedButton(color: Colors.black,
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Login(),
          );
          Navigator.push(context, route);
        },
        child: Text(
          'กลับไปหน้า login',
          style: TextStyle(color: Colors.white),
        ),
      ));
}
