import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/gank_model.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';


//获取干货的provider
class GankProvider with ChangeNotifier{

  final stateUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/";

  final headers = {
    "Content-Type":"application/json;charset=UTF-8"
  };

  LoadState layoutState = LoadState.State_Loading;

  String errorMsg = "";

  GankModel gankModel;

  // 需要传入当前的页码
  getGank(String page) async{
    HttpUtil.get(
        stateUrl+page+"/count/10",
        headers: headers,
        success: (resp){
          gankModel = GankModel.fromJson(resp);

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