import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';
import 'package:provider/provider.dart';


class WeatherNewPage extends StatefulWidget{
  @override
  _WeatherNewPageState createState() => _WeatherNewPageState();
}

class _WeatherNewPageState extends State<WeatherNewPage> {

  List<ProvinceModel> provinceList = [];

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('天气'),
      ),
      body: FutureBuilder(
        future: mockNetworkData(context),
        builder: (context, snapshot){
          //请求数据成功
          if (snapshot.hasData) {
            provinceList = Provider.of<StateProvider>(context, listen: true).provinceList;
            return Container(
              child: ListView.builder(
                itemCount: provinceList.length,
                itemBuilder: buildItem
              ),
            );

          }else{
            return Text("获取数据失败!");
          }
        },
      ),
    );
  }

  Widget buildItem(BuildContext context, int index){
    if (provinceList.length > 0) {
      ProvinceModel model = provinceList[index];
      return InkWell(
        onTap: () {

        },
        child: Text(
            model.name
        ),
      );
    }else{
      return Text("加载数据中....");
    }
  }

  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    await Provider.of<StateProvider>(context, listen: false).getProvince();
    return "end";
  }
}