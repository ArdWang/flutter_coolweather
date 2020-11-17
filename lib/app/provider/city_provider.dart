import 'package:flutter/material.dart';
import '../config/service_url.dart';


//获取城市列表数据

class CityProvider with ChangeNotifier{

  final stateUrl = APP_CITY_SERVICE_ADDRE+"api/china";

  final cityUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}";

  final countryUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}/{cid}";

  //获取省份接口

  getProvince(){

  }


}