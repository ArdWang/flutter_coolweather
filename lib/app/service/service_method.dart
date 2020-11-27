import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';


//获取首页主题内容

Dio dio = Dio()
  ..options.baseUrl = "http//:www.baidu.com"
  ..options.connectTimeout = 10000
  ..options.receiveTimeout = 3000
  ..options.contentType = 'application/x-www-form-urlencoded'
  ..options.responseType = ResponseType.plain;


Future post(String urlKey, {formData}) async {
  try {
    print('开始获取${getServiceName(urlKey)}数据.......');
    Response response;
    if (formData == null) {
      response = await dio.post(servicePath[urlKey]);
    } else {
      response = await dio.post(urlKey, data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('获取数据异常，ERROR: ============$e');
  }
}


Future get(String urlKey, {formData}) async {
  try {
    print('开始获取${getServiceName(urlKey)}数据.......');
    Response response;

    response = await dio.get(urlKey);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('获取数据异常，ERROR: ============$e');
  }
}