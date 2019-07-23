import 'package:flutter/material.dart';

class Draw extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text('设置')
              ),
              onTap: () { Navigator.pushNamed(ctx, '/setting'); },
            ),
          ],
        )
      ),
    );
  }
}
