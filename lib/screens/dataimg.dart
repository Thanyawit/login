import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newlog/screens/home.dart';
import 'package:newlog/screens/login.dart';
import 'package:newlog/uti/dialog.dart';

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
  File _image;
  String urlp;

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
              children: <Widget>[showImage(),dataa(), openn(), Text(''), sevee()],
            ),
          ),
        ));
  }

  Widget openn() => Container(
        width: 150.0,
        child: RaisedButton(
          color: Colors.green,
          onPressed: () {
            chooseFile(ImageSource.gallery);
          },
          child: Text(
            'คลังรูป',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future chooseFile(ImageSource source) async {
    try {
      var object = await ImagePicker.pickImage(
          source: source, maxWidth: 800.0, maxHeight: 800.0);

      setState(() {
        _image = object;
      });
    } catch (e) {}
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.3,child: _image == null ? Text('ไม่มีรูปภาพ') : Image.file(_image),
    );
  }

  Future uploadFile() async {
    Random random = Random();
    int i = random.nextInt(1000);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference = firebaseStorage.ref().child('test/$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    urlp = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('==================$urlp');

    show();
  }

  Widget sevee() => Container(
        width: 150.0,
        child: RaisedButton(
          color: Colors.green,
          onPressed: () {
            if(_image == null){
              normalDialog(context, 'กรุณาใส่รูปภาพ');
            }else{
            uploadFile();
          }
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
    data.child(user).child('note').push().set({
      'MovieTitle': urlp,
      'Date': '${formatter.format(date)}'
    }).asStream();
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home());
    Navigator.push(context, route);
  }
}
