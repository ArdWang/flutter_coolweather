import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/weather_model.dart';
import 'package:flutter_screenutil/screenutil.dart';



class WeatherTipsPage extends StatelessWidget{

  final List<DailyForecast> list;

  WeatherTipsPage(this.list);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: ScreenUtil().setHeight(1000.0),
      child:
        ListView.builder(
            itemCount: list.length,
            itemBuilder: buildItem
        ),
    );
  }

  Widget buildItem(BuildContext context, int index){
    DailyForecast model = list[index];
    return Container(
      //横向
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //左边 右边
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/loading.png',
                width: 40.0,
                height: 40.0
              ),
              Text("小雨")
            ],
          ),
          Column(
            children: [
              Text(model.date),
              Text("最高温度:"+model.tmpMax),
              Text("最低温度:"+model.tmpMin)
            ],
          )
        ],
      ),
    );
  }







}

