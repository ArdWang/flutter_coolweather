import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/news_model.dart';
import 'package:flutter_coolweather/app/utils/httputil.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';



// 新闻返回列表
class NewsProvider with ChangeNotifier{

  //获取新闻的列表信息
  final newsUrl = "https://383659fe-4e5a-4616-923e-83ca7a6242c5.bspapp.com/http/api/v1/news?args=getNews";

  final headers = {
    "Content-Type":"application/json;charset=UTF-8"
  };

  LoadState layoutState = LoadState.State_Loading;

  String errorMsg = "";

  //新闻列表
  List<Data> newsList = [];


  // 获取新闻列表
  getNews(){
    HttpUtil.get(
        newsUrl,
        headers: headers,
        success: (resp){
          //加载成功
          layoutState = LoadState.State_Success;
          newsList = NewsModel.fromJson(resp).data;
          notifyListeners();
        },
        error: (err){
          //加载成功
          layoutState = LoadState.State_Loading;
          errorMsg = err;
          notifyListeners();
        }
    );
  }
}

