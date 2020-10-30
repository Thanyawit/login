import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newlog/screens/home.dart';
import 'package:newlog/screens/register.dart';
import 'package:newlog/uti/dialog.dart';
import 'package:newlog/uti/mystyle.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username, password;
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/1.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showText('แกลลอรี่ของฉัน'),
                MyStyle().showText(''),
                userForm(),
                Text(''),
                passForm(),
                login(),
                register()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() => Container(
        width: 150.0,
        child: RaisedButton(
          color: Colors.green,
          onPressed: () {
            print('user = $username pass = $password');
            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty) {
              print('กรุณากรอกข้อมูล');
              normalDialog(context, 'กรุณากรอกข้อมูล');
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

    var data = database.child("user");
    await data.child(username).once().then((DataSnapshot snapshot){
      print('Data ======>${snapshot.value}');
      if('${snapshot.value}' == 'null'){
        print('user');
        normalDialog(context, 'username ของท่านผิด'); 
      }
      else if(password == '${snapshot.value['password']}'){
        MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home(),);
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
        }else{
        print('รหัสไม่ถูก');
        normalDialog(context,'รหัสไม่ถูกต้อง กรุณากรอกใหม่');
        }
      
      
    });
  }

  Widget register() => Container(
      width: 150.0,
      child: RaisedButton(color: Colors.red,
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Register(),
          );
          Navigator.push(context, route);
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ));

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box,color: Colors.yellow,),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Username',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
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
              prefixIcon: Icon(Icons.lock,color: Colors.yellow),
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );
}
