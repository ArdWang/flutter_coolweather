import 'package:flutter_coolweather/app/model/weather_model.dart';

abstract class WeatherImpl {
  void getWeatherSuccess(List<HeWeather6> result);
  void getWeatherFail(String result);
}