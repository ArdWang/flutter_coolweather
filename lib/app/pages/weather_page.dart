import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:provider/provider.dart';



class WeatherPage extends StatefulWidget{

  @override
  _WeatherPageState createState() => _WeatherPageState();

}


class _WeatherPageState extends State<WeatherPage> {

  //List<StateModel> stateList = [];

  List<ProvinceModel> provinceList = [];

  //默认页面加载中。。。
  LoadState _loadState = LoadState.State_Loading;

  String name = "111";

  @override
  void initState() {

    super.initState();

    //得到省份列表
    provinceList = _getProvinceList();

   // provinceList = stateList[0].data;
    name = provinceList[0].name;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('天气'),
      ),

      body: Text(
        name
      ),

    );
  }


  List<ProvinceModel> _getProvinceList() {
    return Provider.of<StateProvider>(context, listen: false).getProvince();
  }

}