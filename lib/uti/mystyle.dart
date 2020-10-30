import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.orange.shade900;
  Color blueColor = Colors.blue.shade500;
  Color tealColor = Colors.teal.shade500;

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Text showText(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
  Container showlogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/1.png'),
    );
  }


  Container showlogo2() {
    return Container(
      width: 120.0,
      child: Image.asset('images/2.png'),
    );
  }
}
