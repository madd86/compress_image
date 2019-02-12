import 'dart:async';
import 'dart:io';

import 'package:compress_image/compress_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Null> main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<File> _futureImage;
  File _imageFile;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
  }

  Future compressNow() async {
    _futureImage = ImagePicker.pickImage(source: ImageSource.camera);
    //Source of the image in _futureImage
    _imageFile = await _futureImage;
    print("FILE SIZE BEFORE: " + _imageFile.lengthSync().toString());
    await CompressImage.compress(imageSrc: _imageFile.path, desiredQuality: 80); //desiredQuality ranges from 0 to 100
    print("FILE SIZE  AFTER: " + _imageFile.lengthSync().toString());

    setState(() {
      _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Compress Image Example App'),
        ),
        body: new Center(
          child: _imageFile == null
              ? new Text('No image selected.')
              : new Image.file(_imageFile),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            compressNow();
          },
          tooltip: 'Pick Image',
          child: new Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }


  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

}

