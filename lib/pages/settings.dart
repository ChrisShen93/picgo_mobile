import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置页')
      ),
      body: Text('设置')
    );
  }
}
