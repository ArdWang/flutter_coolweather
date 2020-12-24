import 'package:dio/dio.dart';
import 'dart:async';
//import '../config/service_url.dart';


/*
  @author rnd
  2020 11/17 星期二
*/

// https://javiercbk.github.io/json_to_dart/

class HttpUtil {

  static void get(String url,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function success,
        Function error
      }) async {
    // 数据拼接
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('$key=$value');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }

    // 发送get请求
    await _sendRequest(
        url,
        'get',
        success,
        headers: headers,
        error: error
    );
  }

  static void post(String url,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function success,
        Function error
      }) async {
    // 发送post请求
    _sendRequest(
        url,
        'post',
        success,
        data: data,
        headers: headers,
        error: error
    );
  }


  static void put(String url,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function success,
        Function error
      }) async {
    // 发送post请求
    _sendRequest(
        url,
        'put',
        success,
        data: data,
        headers: headers,
        error: error
    );
  }

  // Api resultful 请求 delete
  static void delete(String url,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function success,
        Function error
      }) async {
    // 发送post请求
    _sendRequest(
        url,
        'delete',
        success,
        data: data,
        headers: headers,
        error: error
    );
  }


  // 请求处理
  static Future _sendRequest(String url,
      String method,
      Function success,
      {
        Map<String, dynamic> data,
        Map<String, dynamic> headers,
        Function error
      }) async {
    int _code;
    String _msg;
    var _backData;

    // 检测请求地址是否是完整地址
    if (!url.startsWith('http')) {
      url = url;
    }

    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;

      // 配置dio请求信息
      Response response;
      Dio dio = Dio()
        ..options.baseUrl = url
        ..options.connectTimeout = 10000
        ..options.receiveTimeout = 3000 // 响应流上前后两次接受到数据的间隔，毫秒
        ..options.headers.addAll(headersMap);
      //..options.responseType = ResponseType.plain;

      if (method == 'get') {
        response = await dio.get(url);
      } else {
        response = await dio.post(url, data: dataMap);
      }

      if (response.statusCode != 200) {
        _msg = '网络请求错误,状态码:' + response.statusCode.toString();
        _handError(error, _msg);
        return;
      }

      // 返回结果处理
      //Map<String, dynamic> resCallbackMap = response.data;
      //_code = resCallbackMap['code'];
      //_msg = resCallbackMap['message'];
      //_backData = resCallbackMap['data'];

      if (success != null) {
        success(response.data);
      }
    } catch (exception) {
      print("网络错误原因" + exception.toString());
      //FlutterError
      var err = "获取数据失败!";
      _handError(error, err);
    }
  }

  // 返回错误信息
  static Future _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }

  //  error统一处理
  static String formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      return "网络连接超时";
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      return "网络请求超时";
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      return "网络响应超时";
    } else if (e.type == DioErrorType.RESPONSE) {
      return "网络出现异常";
    } else if (e.type == DioErrorType.CANCEL) {
      return "网络请求取消";
    } else {
      return "网络未知错误";
    }
  }

}

