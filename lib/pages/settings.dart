import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences prefs;

  TextEditingController _repoController = new TextEditingController();
  TextEditingController _branchController = new TextEditingController();
  TextEditingController _tokenController = new TextEditingController();
  TextEditingController _pathController = new TextEditingController();
  TextEditingController _customUrlController = new TextEditingController();

  void initState () {
    super.initState();
    _initPrefs();
  }

  void _initPrefs () async {
    prefs = await SharedPreferences.getInstance();
    GithubSetting setting = new GithubSetting.fromJson(jsonDecode(prefs.getString('github_settings')));
    setState(() {
      _repoController.text = setting.repo;
      _branchController.text = setting.branch;
      _tokenController.text = setting.token;
      _pathController.text = setting.path;
      _customUrlController.text = setting.customUrl;
    });
  }

  void saveSettings () async {
    var state = _formKey.currentState as FormState;
    if (state.validate()) {
      GithubSetting githubSetting = new GithubSetting(
        _repoController.text,
        _branchController.text,
        _tokenController.text,
        _pathController.text,
        _customUrlController.text
      );
      prefs.setString('github_settings', jsonEncode(githubSetting));
    } else {
      print('有错误');
    }
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
                controller: _repoController,
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
                controller: _branchController,
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
                controller: _tokenController,
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
                controller: _pathController,
                decoration: InputDecoration(
                  labelText: '指定存储路径',
                  hintText: '例如：img/',
                  prefixIcon: Icon(Icons.folder),
                ),
              ),
              TextFormField(
                controller: _customUrlController,
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

class GithubSetting {
  String repo;
  String branch;
  String token;
  String path;
  String customUrl;

  // GithubSetting (String repo, String branch, String token, String path, String customUrl) {
  //   this.repo = repo;
  //   this.branch = branch;
  //   this.token = token;
  //   this.path = path;
  //   this.customUrl = customUrl;
  // }
  GithubSetting (this.repo, this.branch, this.token, this.path, this.customUrl);

  Map toJson () {
    Map map = new Map();
    map['repo'] = this.repo;
    map['branch'] = this.branch;
    map['token'] = this.token;
    map['path'] = this.path;
    map['customUrl'] = this.customUrl;
    return map;
  }

  factory GithubSetting.fromJson (Map<String, dynamic> settingJson) {
    return GithubSetting(
      settingJson['repo'],
      settingJson['branch'],
      settingJson['token'],
      settingJson['path'],
      settingJson['customUrl'],
    );
  }
}
