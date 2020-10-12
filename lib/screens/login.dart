import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newlog/screens/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Colors.yellow],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[userForm(), Text(''), passForm(), login()],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Colors.black,
          onPressed: () {
            print('user = $username pass = $password');
            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty) {
              print('กรุณากรอกข้อมูล');
            } else {
              loginserve();
            }
          },
          child: Text(
            'Singin',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> loginserve() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: username, password: password)
        .then((value) {
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => Home(),
      );
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    });
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              labelStyle: TextStyle(color: Colors.deepOrangeAccent),
              labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        ),
      );

  Widget passForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelStyle: TextStyle(color: Colors.deepOrangeAccent),
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        ),
      );
}
