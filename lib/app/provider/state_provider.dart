import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/city_model.dart';
import 'package:flutter_coolweather/app/model/country_model.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/service/service_method.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';
import '../config/service_url.dart';


//获取城市列表数据

class StateProvider with ChangeNotifier{

  final stateUrl = APP_CITY_SERVICE_ADDRE+"api/china";

  final cityUrl = APP_CITY_SERVICE_ADDRE+"api/china/";

  final countryUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}/{cid}";

  // 获取省份列表
  List<ProvinceModel> provinceList = [];

  List<CitiesModel> citiesList = [];

  List<CountriesModel> countriesList = [];

  String errorMsg = "";

  var headers = {
    "Content-Type":"application/json;charset=UTF-8"
  };

  //获取省份接口
  getProvince() async{
    //方案1
    HttpUtil.get(
      stateUrl,
      headers: headers,
      success: (resp){
       provinceList = StateModel.fromJson(resp).data;
       notifyListeners();
      },
      error: (err){
        errorMsg = err;
        notifyListeners();
      }
    );

    //方案2
    // await get(stateUrl).then((value){
    //   provinceList = StateModel.fromJson(value).data;
    //   print(provinceList.toString());
    //   notifyListeners();
    // });
  }

  // 获取市列表
  getCity(String pid) async{
    HttpUtil.get(
        stateUrl+"/"+pid,
        headers: headers,
        success: (resp){
          citiesList = CityModel.fromJson(resp).data;
          notifyListeners();
        },
        error: (err){
          errorMsg = err;
          notifyListeners();
        }
    );
  }


  getCountry(String pid,String cid) async{
    HttpUtil.get(
        stateUrl+"/"+pid+"/"+cid,
        headers: headers,
        success: (resp){
          countriesList = CountryModel.fromJson(resp).data;
          notifyListeners();
        },
        error: (err){
          errorMsg = err;
          notifyListeners();
        }
    );
  }





}