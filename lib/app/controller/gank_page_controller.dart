import 'package:flutter_coolweather/app/model/gank_model.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:get/get.dart';


class GankPageController extends GetxController{

  final stateUrl = "https://gank.io/api/v2/data/category/Girl/type/Girl/page/";

  final headers = {
    "Content-Type":"application/json;charset=UTF-8"
  };

 // LoadState layoutState = LoadState.State_Loading;

  var layoutState = LoadState.State_Loading.obs;

  String errorMsg = "";

  //GankModel gankModel;

  var gankModel = GankModel().obs;


  getGank(String page) async{
    HttpUtil.get(
        stateUrl+page+"/count/10",
        headers: headers,
        success: (resp){
          gankModel = GankModel.fromJson(resp).obs;
          //加载成功
          layoutState = LoadState.State_Success.obs;
        },
        error: (err){
          errorMsg = err;
          //加载失败
          layoutState = LoadState.State_Error.obs;
        }
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

}


