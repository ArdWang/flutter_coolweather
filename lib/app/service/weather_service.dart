import 'package:flutter_coolweather/app/config/service_url.dart';
import 'package:flutter_coolweather/app/model/weather_model.dart';
import 'package:flutter_coolweather/app/service/impl/weather_impl.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';


class WeatherService{

  WeatherImpl _impl;

  WeatherService(this._impl);

  //获取天气信息
  getWeather(String location, String key){

    final stateUrl = APP_WEATHER_SERVICE_ADDRE+"s6/weather?location="+location+"&key="+APP_WEATHER_KEY;

    var headers = {
      "Content-Type": "application/json;charset=UTF-8"
    };

    HttpUtil.get(
        stateUrl,
        headers: headers,
        success: (resp){
          List<HeWeather6> list = WeatherModel.fromJson(resp).heWeather6;

          _impl.getWeatherSuccess(list);
        },
        error: (err){
          _impl.getWeatherFail(err);
        }
    );
  }

}