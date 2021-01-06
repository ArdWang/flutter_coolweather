import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/state_model.dart';
import 'package:flutter_coolweather/app/model/weather_model.dart';
import 'package:flutter_coolweather/app/pages/weather/weather_pop_page.dart';
import 'package:flutter_coolweather/app/provider/gank_provider.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';
import 'package:flutter_coolweather/app/provider/weather_provider.dart';
import 'package:flutter_coolweather/app/utils/function_util.dart';
import 'package:flutter_coolweather/app/utils/show_bottom_dialog.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class WeatherPage extends StatelessWidget{

  // 省份列表
  List<ProvinceModel> provinceList = [];

  // 默认是北京市的天气
  String defaultCode = "CN101010100";

  // 默认城市名
  String defaultName = "北京";

  // 和风天气  不然会报错 定义命名
  List<HeWeather6> heList = [];

  //页面加载状态，默认为加载中
  var _layoutState = LoadState.State_Loading;

  @override
  Widget build(BuildContext context) {

    // 返回脚手架
    return Scaffold(
      appBar: AppBar(
        title: Text('天气'),
      ),
      body: FutureBuilder(
          future: mockNetworkData(context),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              heList = Provider.of<WeatherProvider>(context, listen: true).heList;
              provinceList = Provider.of<StateProvider>(context, listen: true).provinceList;
              return Container(
                child: _loadStateLayout(context),
              );
            }else{
              return Text("获取数据错误");
            }
          }
      ),
    );
  }

  // 加载状态栏
  Widget _loadStateLayout(BuildContext context){
    //当前的
    _layoutState = Provider.of<GankProvider>(context,listen: false).layoutState;

    // if(heList.length == 0){
    //   return LoadStateLayout(
    //     state: _layoutState,
    //     emptyRetry: () {
    //       _layoutState = LoadState.State_Loading;
    //       mockNetworkData(context);
    //     }
    //   );
    // }else {
      return LoadStateLayout(
        state: _layoutState,
        emptyRetry: () {
          _layoutState = LoadState.State_Loading;
          mockNetworkData(context);
        },
        errorRetry: () {
          _layoutState = LoadState.State_Loading;
          mockNetworkData(context);
        },
        successWidget: Center(
          child: EasyRefresh(
            //显示布局
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/bg2.jpg")
                )
              ),
              child: Column(
                children: [
                  Row(
                    // 控件左右排列对齐
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //左边图片显示
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/weather/' + heList[0].now.condCode +
                              ".png",
                          width: 120.0,
                          height: 120.0,
                        ),
                      ),

                      //右边的显示
                      Column(
                        children: [
                          //文字显示
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: FlatButton(
                              child: Text(
                                defaultName,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  )
                              ),
                              onPressed: (){
                                if (provinceList.length > 0) {
                                  //执行点击事件
                                  // Navigator.of(context).push(
                                  //   WeatherPopPage(provinceList),
                                  // );

                                  FunctionUtil.bottomSheetDialog(
                                    context,
                                    ShowCupertinoDialog(
                                      items: provinceList,
                                      onTap: (int index, String res) {
                                        print('object$index + $res');
                                      },
                                    ),
                                  );

                                }else{
                                  print("还不能执行操作!");
                                }
                              },
                            ),
                          ),
                          //温度显示
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
                            child: Text(
                              heList[0].now.tmp+"°",
                              style: TextStyle(
                                  fontSize: 100.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //下一排的排列
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //左边显示
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Text(
                          heList[0].now.condTxt,
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                        )
                      ),
                      //右边显示 最近7天的温度显示
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: FlatButton(
                            child: Text(
                                "最近7天的天气",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                )
                            ),
                            onPressed: (){
                              //执行点击事件
                              print("你点击了我");
                            },
                          ),
                      )
                    ],
                  ),
                  //最后一排的数据显示
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "生活方式",
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54
                            ),
                        ),
                      ),
                      // 生活建议 列表的形式
                      Container(
                        height: 200.0,
                        //整个屏幕的高度
                        child: Row(
                          children: [
                            Expanded(
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: heList[0].lifestyle.length > 0 ? heList[0].lifestyle.length:0,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 5.0,
                                    crossAxisSpacing: 5.0,
                                    childAspectRatio: 1.5,
                                  ),
                                  itemBuilder: buildItem,
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            header: ClassicalHeader(
              refreshText: '下拉刷新',
              refreshReadyText: '释放刷新',
              refreshingText: '正在刷新...',
              refreshedText: '刷新完成',
              refreshFailedText: '刷新失败',
              noMoreText: '没有更多',
              infoText: '更新于 %T',
            ),

            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              //刷新的时候清除数据
              //dataList.clear();
              mockNetworkData(context);
            },
          ),
        ),
      );
    //}
  }

  Widget buildItem(BuildContext context, int index){
    //获取数据
    Lifestyle lifestyle = heList[0].lifestyle[index];
    return Container(
      child: Column(
        children: [
          Text(
              lifestyle.brf,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              )
          ),
          Text(
              lifestyle.txt,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white54
              )
          )
        ],
      ),
    );
  }


  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    await Provider.of<WeatherProvider>(context, listen: false).getWeather(defaultCode);
    await Provider.of<StateProvider>(context, listen: false).getProvince();
    return "end";
  }

}

