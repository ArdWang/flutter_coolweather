

/*
  WeatherPopPage 界面布局
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';

class WeatherPopPage<T> extends PopupRoute<T>{

  final String barrierLabel;

  List<ProvinceModel> provinceList;

  int startX;

  int endX;

  WeatherPopPage(this.provinceList,{this.barrierLabel});

  Duration get transitionDuration => Duration(milliseconds: 2000);

  Color get barrierColor => Colors.black54;

  bool get barrierDismissible => true;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: GestureDetector(
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) => GestureDetector(
              onTap: () {
                //Navigator.pop(context);
                print("不要来点击我");
              },
              child: WeatherPageShow(provinceList),
            ),
          ),
          onTap: (){
            Navigator.pop(context);
          },
        )
    );
  }

}


// ignore: must_be_immutable
class WeatherPageShow extends StatelessWidget{

  List<ProvinceModel> provinceList;

  WeatherPageShow(this.provinceList);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text("城市"),
        ListView.builder(
          itemCount: provinceList.length,
          itemBuilder: buildItem,
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index){
    ProvinceModel p = provinceList[index];
    //获取数据
    return Container(
      child:
          Text(
              p.name,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54
              )
          ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
      ),
    );
  }


}