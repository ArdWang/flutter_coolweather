import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/city_model.dart';
import 'package:flutter_coolweather/app/model/country_model.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';
import 'package:flutter_coolweather/app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

//自定义 dialog

// ignore: must_be_immutable
class SelectDialog extends Dialog {

  // 当前默认为0
  int currentLevel = 0;

  final String title;

  List<ProvinceModel> provinceList = [];

  List<CitiesModel> citiesList = [];

  List<CountriesModel> countriesList = [];

  List<String> dataList = [];

  ProvinceModel provinceModel;

  CitiesModel citiesModel;

  CountriesModel countriesModel;

  String defaultCode = "CN101010100";

  SelectDialog(this.title);

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockNetworkData(context),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            // 获取当前的级别
            if (currentLevel == 0){
              dataList.clear();
              provinceList = Provider.of<StateProvider>(context, listen: true).provinceList;
              for(ProvinceModel p in provinceList){
                dataList.add(p.name);
              }
            }else if(currentLevel == 1){
              dataList.clear();
             citiesList = Provider.of<StateProvider>(context, listen: true).citiesList;
             for(CitiesModel c in citiesList){
               dataList.add(c.name);
             }
            }else if(currentLevel == 2){
              dataList.clear();
              countriesList = Provider.of<StateProvider>(context, listen: true).countriesList;
              for(CountriesModel c in countriesList){
                dataList.add(c.name);
              }
            }

            return Material(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colors.white),
                  ),

                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 200,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Align(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              alignment: Alignment.topCenter,
                            ),
                            Align(
                              child: InkWell(
                                child: Icon(Icons.close),
                                onTap: () => Navigator.pop(context),
                              ),
                              alignment: Alignment.topRight,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 290,
                        child: ListView.builder(
                          itemBuilder: buildItem,
                          itemCount: dataList.length,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              ),
              type: MaterialType.transparency,
              //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            );
          }else{
            return Text("获取数据错误");
          }
        }
    );
  }

  // 返回itemCount
  // int _itemCount(){
  //   if(currentLevel == 0){
  //     return provinceList.length;
  //   }else if(currentLevel == 1){
  //     return citiesList.length;
  //   }else{
  //     return countriesList.length;
  //   }
  // }

  Widget buildItem(BuildContext context, int index) {
    // 获取数据
    //ProvinceModel model = provices[index];
    String name = dataList[index];
    // 选择点击 item
    var item = InkWell(
      onTap: () {
        print("我是点击事件-1");

        //继续执行加载
        switch(currentLevel){
          case 0:{
            provinceModel = provinceList[index];
            getCities(context, provinceModel.id.toString());
            //当前的等级
            currentLevel = 1;
          }
          break;

          case 1:{
            citiesModel = citiesList[index];
            getCountries(context, provinceModel.id.toString(), citiesModel.id.toString());
            currentLevel = 2;
          }
          break;

          case 2:{
            countriesModel = countriesList[index];
            defaultCode = countriesModel.name;
            getWeather(context);
            // 获取天气数据 首先关闭
            Navigator.pop(context);
          }
          break;
        }
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16
            ),
          ),
        ),
        // 下边框
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
        ),
      ),
    );
    return item;
  }


  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    await Provider.of<StateProvider>(context, listen: false).getProvince();
    return "end";
  }

  // 得到省份 城市 乡村
  getProvince(BuildContext context) async{
    await Provider.of<StateProvider>(context, listen: false).getProvince();
  }
  
  getCities(BuildContext context, String pid) async{
    await Provider.of<StateProvider>(context, listen: false).getCity(pid);
  }

  getCountries(BuildContext context,String pid,String cid) async{
    await Provider.of<StateProvider>(context, listen: false).getCountry(pid, cid);
  }

  getWeather(BuildContext context) async{
    await Provider.of<WeatherProvider>(context, listen: false).getWeather(defaultCode);
  }
  
  
}



/*

final String title;

  final List<ProvinceModel> provices;

  SelectDialog(this.title, this.provices);

  Widget build(BuildContext context){
    return Material(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height-200,
          width: MediaQuery.of(context).size.width-40,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      child: Text(title),
                      alignment: Alignment.topCenter,
                    ),
                    Align(
                      child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () => Navigator.pop(context),
                      ),
                      alignment: Alignment.topRight,
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height-290,
                child: ListView.builder(
                  itemBuilder: buildItem,
                  itemCount: provices.length,
                ),
                padding: EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      ),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
    );
  }

  Widget buildItem(BuildContext context, int index) {
    // 获取数据
    ProvinceModel model = provices[index];
    // 选择点击 item
    var item = InkWell(
      onTap: () {
        print("我是点击事件-1");
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            model.name,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16
            ),
          ),
        ),
        // 下边框
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
        ),
      ),
    );
    return item;
  }

*/
