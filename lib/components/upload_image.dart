import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;

  Future getImage(String type) async {
    var image;
    if (type == 'gallery') {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } else if (type == 'camera') {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Center(
        child: _image == null
          ? Text('No Image Selected.')
          : Image.file(_image),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () { getImage('camera'); },
            tooltip: 'Pick image',
            // important: when there are multiple fab, each of them should have a heroTag,
            // otherwise an error will be thrown
            heroTag: 'camera',
            child: Icon(Icons.add_a_photo),
          ),
          FloatingActionButton(
            onPressed: () { getImage('gallery'); },
            tooltip: 'Pick image',
            heroTag: 'gallery',
            child: Icon(Icons.photo_album),
          ),
        ],
      ),
    );
  }
}
