

import 'package:flutter_coolweather/app/config/service_url.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/service/impl/state_impl.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';

class StateService{

  final stateUrl = APP_CITY_SERVICE_ADDRE+"api/china";

  //final cityUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}";

  //final countryUrl = APP_CITY_SERVICE_ADDRE+"api/china/{pid}/{cid}";

  StateImpl _impl;

  StateService(this._impl);




  // 获取省份列表

  void getProvince(){

    var headers = {
      "Content-Type": "application/json;charset=UTF-8"
    };

    HttpUtil.get(
        stateUrl,
        headers: headers,
        success: (resp){
          List<ProvinceModel> list = StateModel.fromJson(resp).data;
          _impl.getStateSuccess(list);
        },
        error: (err){
          _impl.getStateFail(err);
        }
    );
  }


  // 获取市级列表

  void getCity(int pid){

    var strUrl = APP_CITY_SERVICE_ADDRE+"api/china/"+pid.toString();

    var headers = {
      "Content-Type": "application/json;charset=UTF-8"
    };

    HttpUtil.get(
        strUrl,
        headers: headers,
        success: (resp){
          List<ProvinceModel> list = StateModel.fromJson(resp).data;
          _impl.getStateSuccess(list);
        },
        error: (err){
          _impl.getStateFail(err);
        }
    );




  }


}