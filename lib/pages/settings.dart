import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  GlobalKey _formKey = new GlobalKey<FormState>();

  void saveSettings () {
    (_formKey.currentState as FormState).save();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置页')
      ),
      body: Padding(
        // padding: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                autovalidate: true,
                decoration: InputDecoration(
                  labelText: '设定仓库名',
                  hintText: '格式：username/repo',
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : '仓库名不可为空';
                },
              ),
              TextFormField(
                autovalidate: true,
                decoration: InputDecoration(
                  labelText: '设定分支名',
                  hintText: '例如：master',
                  prefixIcon: Icon(Icons.call_split),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : '分支名不可为空';
                },
              ),
              TextFormField(
                autovalidate: true,
                decoration: InputDecoration(
                  labelText: '设定Token',
                  hintText: 'token',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : 'Token不可为空';
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '指定存储路径',
                  hintText: '例如：img/',
                  prefixIcon: Icon(Icons.folder),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '设定自定义域名',
                  hintText: '例如：https://xxx.com',
                  prefixIcon: Icon(Icons.domain),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('保存'),
                        onPressed: () {
                          saveSettings();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
