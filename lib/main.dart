import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newlog/screens/login.dart';


void main() async {
  // these 2 lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Login()
    );
  }
}
