import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './GithubSetting.dart';

class HttpUtils {
  static Dio dio;
  static SharedPreferences prefs;

  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'PATCH';
  static const String DELETE = 'delete';


  static Future<Map> request (
    String url,
    { data, method, option }
  ) async {
    data = data ?? {};
    method = method ?? 'GET';
    option = option ?? {};

    Dio dio = createInstance(option);

    var result;

    try {
      Response resp = await dio.request(url, data: data, options: new Options(method: method));
      result = resp.data;
      showToast('上传成功！');
    } on DioError catch (e) {
      showToast('请求错误：' + e.toString());
    }

    return result;
  }

  static Dio createInstance (option) {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        // important: 不能通过点语法访问
        baseUrl: option['baseUrl'] ?? '',
        headers: option['headers'] ?? {},
      );
      dio = new Dio(options);
    }
    return dio;
  }

  static clear () {
    dio = null;
  }

  static getPrefsByType (String type) async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    var setting;
    try {
      setting = json.decode(prefs.getString('${type}_settings'));
    } catch (e) {
      showToast('请先配置当前图床');
    }
    return setting;
  }

  static githubReq (File image) async {
    var settingCache = await getPrefsByType('github');
    if (settingCache == null) return;
    List<int> imageBytes = await image.readAsBytes();
    GithubSetting setting = new GithubSetting.fromJson(settingCache);
    request(
      '/repos/${setting.repo}/contents/${Uri.encodeComponent(setting.path)}/${Uri.encodeComponent(basename(image.path))}',
      method: PUT,
      data: {
        'message': 'PicGo_mobile upload',
        'content': base64.encode(imageBytes),
        'branch': setting.branch,
      },
      option: {
        'baseUrl': 'https://api.github.com',
        'headers': {
          'Authorization': 'token ${setting.token}',
          'User-Agent': 'PicGo_mobile',
        },
      },
    );
  }
}
