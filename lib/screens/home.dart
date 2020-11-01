import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:newlog/screens/dataimg.dart';
import 'package:newlog/screens/datashow.dart';
import 'package:newlog/screens/login.dart';

String url;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Login login;
  final database = FirebaseDatabase.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<Datashow> datashows = List();

  @override
  void initState() {
    super.initState();
    show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โน้ต'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () {
                signOut(context);
              })
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/4.jpg'), fit: BoxFit.cover)),
        child: ListView.builder(
            itemCount: datashows.length,
            itemBuilder: (BuildContext con, int index) {
              return showlistview(index);
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Dataimgg());
            Navigator.push(context, route);
          },
          label: Text('ที่บันทึกรูปภาพ')),
    );
  }

  Widget showname(int index) {
    return Text('วันที่อัพเดท ${datashows[index].date}');
  }

  Widget showtext(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.1,
      child: Column(
        children: <Widget>[showname(index)],
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(datashows[index].movieTitle),
    );
  }

  Widget showlistview(int index) {
    return Row(
      children: <Widget>[showImage(index), showtext(index)],
    );
  }

  Future<Null> show() async {
    DatabaseReference databaseReference = database.reference().child('user');
    databaseReference
        .child(user)
        .child('note')
        .once()
        .then((DataSnapshot snapshot) {
      print(snapshot.value);
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values['MovieTitle']);

        Datashow datashow = Datashow.formMap(values);
        print(datashow.toString());
        setState(() {
          datashows.add(datashow);
        });
      });
    });
  }

  void signOut(BuildContext context) {
    firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName('/'));
  }
}
