import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/weather_model.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';


// 天气的提供者
class WeatherProvider with ChangeNotifier{

  // 获取天气列表
  List<HeWeather6> heList = [];

  String serverAddress = "https://free-api.heweather.com/";

  String weatherKey = "c0d50dd43adb4a62aff5f3f728941082";

  final headers = {
    "Content-Type":"application/json;charset=UTF-8"
  };

  LoadState layoutState = LoadState.State_Loading;

  String errorMsg = "";

  /*
   * 得到当前的天气接口
   */
  getWeather(String location) async{
    HttpUtil.get(
      serverAddress+"s6/weather?location="+location+"&key="+weatherKey,
      headers: headers,
      success: (resp){
        heList = WeatherModel.fromJson(resp).heWeather6;
        //加载成功
        layoutState = LoadState.State_Success;
        notifyListeners();
      },
      error: (err){
        errorMsg = err;
        //加载失败
        layoutState = LoadState.State_Error;
        notifyListeners();
      }
    );
  }




}