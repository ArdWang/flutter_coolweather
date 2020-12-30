import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/news_model.dart';
import 'package:flutter_coolweather/app/model/nnews_model.dart';
import 'package:flutter_coolweather/app/provider/news_provider.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import 'package:video_player/video_player.dart';


// ignore: must_be_immutable
class HomePage extends StatelessWidget{
  
  LoadState _layoutState = LoadState.State_Loading;

  String errorMsg = "";

  //新闻列表
  List<Data> newsList = [];

  List<String> imgList = [];

  VideoPlayerController _controller;

  Future<void> _initializeVideoPlayerFuture;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('新闻'),
        ),
        body: FutureBuilder(
          future: mockNetworkData(context),
          builder: (context, snapshot) {
            //请求数据成功
            if (snapshot.hasData) {
              newsList = Provider.of<NewsProvider>(context, listen: true)
                  .newsList;
              return Container(
                child: _loadStateLayout(context),
              );
            } else {
              return Text("获取数据失败!");
            }
          },
        ));
  }


  // 加载状态栏
  Widget _loadStateLayout(BuildContext context) {
    //当前的
    _layoutState = Provider
        .of<NewsProvider>(context, listen: false)
        .layoutState;

    // if (newsList.length == 0) {
    //   return LoadStateLayout(
    //       state: _layoutState,
    //       emptyRetry: () {
    //         _layoutState = LoadState.State_Loading;
    //         mockNetworkData(context);
    //       }
    //   );
    // } else {
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
              child: ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: buildItem
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
                onRefresh: () async{
                  await Future.delayed(Duration(milliseconds: 1000));
                  //刷新的时候清除数据
                  newsList.clear();
                  mockNetworkData(context);
                }
            )
          )
        //显示布局

      );
    //}
  }

  // ignore: missing_return
  Widget buildItem(BuildContext context, int index) {
    //网络数据的处理
    Data data = newsList[index];

    NnewsModel n = NnewsModel();

    //重组 列表 算法
    n.title = data.title;
    n.time = data.adate;

    if(data.address != "" && data.address != null){
      n.category = 1;
      n.address = data.address;
    }else{
      if(data.news.length > 0){
        n.top3Images = new List();
        for( var m in data.news){
          if(m.j != "" && m.j != null){
            n.category = 2;
            n.top3Images.add(m.j);
            if(n.top3Images.length > 2){
              imgList = n.top3Images;
              break;
            }
          }
        }
      }else{
        n.category = 0;
      }
    }

    //显示n的list 布局
    if(n.category == 2){
      //显示布局 第2种 标题和下面是图片的显示 在Flutter 的Column或者Rowt内使用ListView.builder()需要对改ListView的大小进行指定.
      // 具体的解决办法就是 在该ListView.builder()外嵌套一个SizeBox或者Container即可…
      return Container(
        child: Column(
          children: [
            //标题
            Text(n.title),
            SizedBox(
              height: 100.0,
              child: //内容显示
              GridView.builder(
                  itemCount: imgList.length > 0 ? imgList.length:0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: gridViewItem
              ),
            )
          ],
        ),
      );
      
    }else if(n.category == 1){

      _controller = VideoPlayerController.network(
        n.address,
      );

      // Initialize the controller and store the Future for later use.
      _initializeVideoPlayerFuture = _controller.initialize();

      // Use the controller to loop the video.
      _controller.setLooping(true);

      //自动播放
      _controller.play();

      //显示视频
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(n.title),
            SizedBox(
              width: 100,
              height: 70,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              ),
            )
          ],
        ),
      );

    }else{

      //不显示图片和视频
      return Container(
        child: Text(
          n.title
        ),
      );
    }
  }

  //gridView item的布局
  Widget gridViewItem(BuildContext context, int index){
    String img = imgList[index];
    return InkWell(
      onTap: () {
        
      },
      child: CachedNetworkImage(
        imageUrl: img,
        placeholder: (context, url) =>
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              width: 100.0,
              height: 80.0,
            ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }


  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    await Provider.of<NewsProvider>(context, listen: false).getNews();
    return "end";
  }



}