import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_coolweather/app/pages/drawer_page.dart';
import 'package:flutter_coolweather/app/pages/gank_page.dart';
import 'package:flutter_coolweather/app/pages/home_page.dart';
import 'package:flutter_coolweather/app/pages/weather_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class IndexPage extends StatefulWidget{
  @override
  _IndexPageState createState() => _IndexPageState();
}


class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        title: Text('首页')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.brightness),
        title: Text('天气')
    ),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart),
        title: Text('干货')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    WeatherPage(),
    GankPage()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      drawer: Drawer(
        child: DrawerLeftPage(),
      ),
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}