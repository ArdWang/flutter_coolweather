import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/config/service_url.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/model/weather_model.dart';
import 'package:flutter_coolweather/app/pages/weather/weather_tips_page.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';
import 'package:flutter_coolweather/app/service/impl/state_impl.dart';
import 'package:flutter_coolweather/app/service/impl/weather_impl.dart';
import 'package:flutter_coolweather/app/service/state_service.dart';
import 'package:flutter_coolweather/app/service/weather_service.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:flutter_coolweather/app/widgets/toast_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';



class WeatherPage extends StatefulWidget{

  @override
  _WeatherPageState createState() => _WeatherPageState();

}


class _WeatherPageState extends State<WeatherPage> with AutomaticKeepAliveClientMixin, StateImpl,WeatherImpl{

  @protected
  bool get wantKeepAlive=>true;

  //List<StateModel> stateList = [];

  List<ProvinceModel> provinceList = [];

  //默认页面加载中。。。
  LoadState _loadState = LoadState.State_Loading;

  String name = "111";

  // 默认是北京市的天气
  String default_code = "CN101010100";

  // 和风天气
  List<HeWeather6> heList = [];




  @override
  void initState() {

    super.initState();

    loadState();

  }



  /*
  *
  * Container(
        child: ListView.builder(
            itemCount: provinceList.length,
            itemBuilder: buildItem
        )
  * */

  @override
  Widget build(BuildContext context) {
    //_getProvince(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('天气'),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bg1.jpg"),
            ),
          ),

        child: Container(
          child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver:SliverList(
                        delegate: SliverChildListDelegate(
                            [
                              // 头部
                              Text("我是头部"),
                              // 内容
                              weatherTips(),
                              // 空气指数
                              Text("我是空气指数")
                            ]
                        )
                    )
                ),
              ]
              ,
            )

        ),
      ),

    );
  }

  /*

  []: CustomScrollView(
            shrinkWrap: false,
            slivers: [
              // 头部

              // 内容
              weatherTips()

              // 空气指数
            ],
          )

  */


  Widget weatherTips(){
    if (heList.length > 0){
      return WeatherTipsPage(heList.single.dailyForecast);
    }else{
      return Text("加载中...");
    }
  }


  Widget buildItem(BuildContext context, int index){
    ProvinceModel model = provinceList[index];
    return InkWell(
      onTap: (){

      },
      child: Text(
        model.name
      ),
    );
  }


  void loadState(){
    var data = WeatherService(this);
    //data.getProvince();
    data.getWeather(default_code, APP_WEATHER_KEY);
  }


  @override
  void getStateSuccess(List result) {
    setState(() {
      _loadState = LoadState.State_Success;
    });

    provinceList = result;

  }


  @override
  void getStateFail(String result) {
    _showSnackBar(context, result);
  }


  void _showSnackBar(BuildContext context, String text) {
    Toast.toast(context,msg: text,position: ToastPostion.bottom);
  }

  @override
  void getWeatherFail(String result) {
    _showSnackBar(context, result);
  }

  @override
  void getWeatherSuccess(List<HeWeather6> result) {
    setState(() {
      _loadState = LoadState.State_Success;
    });

    heList = result;
  }





}