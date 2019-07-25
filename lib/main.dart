import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import './components/upload_image.dart';
import './components/draw.dart';
import './components/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.grey,
      child: MaterialApp(
        title: 'PicGo mobile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router.generateRoutes,
        home: Home(title: 'PicGo mobile'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({ Key key, this.title }) : super(key: key);

  final String title;

  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
      ),
      drawer: new Draw(),
      body: UploadImage(),
    );
  }
}
