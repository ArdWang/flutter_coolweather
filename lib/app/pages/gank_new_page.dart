import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/controller/gank_page_controller.dart';
import 'package:flutter_coolweather/app/model/gank_model.dart';
import 'package:flutter_coolweather/app/utils/fade_route.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import 'gank/photo_gallery_page.dart';


// ignore: must_be_immutable
class GankNewPage extends StatelessWidget{

  var page = 1;

  //页面加载状态，默认为加载中
  var _layoutState = LoadState.State_Loading;

  GankModel gankModel;

  //data 列表
  List<Data> dataList = [];

  final g = Get.put(GankPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('福利'),
      ),
      body: FutureBuilder(
          future: mockNetworkData(context),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              //gankModel = Get.find<GankPageController>().gankModel as GankModel;
             // gankModel = g.gankModel;
              return Container(
                child: Obx(()=>_loadStateLayout(context)),
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
    _layoutState = g.layoutState.value;
    gankModel = g.gankModel.value;

    //数组合并
    dataList.addAll(gankModel.data);

    return LoadStateLayout(
      state: _layoutState,
      emptyRetry: (){
        _layoutState = LoadState.State_Loading;
        mockNetworkData(context);
      },
      errorRetry: (){
        _layoutState = LoadState.State_Loading;
        mockNetworkData(context);
      },
      successWidget: Center(
        child: EasyRefresh(
          //GridView布局
          child: GridView.builder(
            itemCount: dataList.length > 0 ? dataList.length:0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.7,
            ),
            itemBuilder: buildItem,
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
          footer: ClassicalFooter(
              loadedText: '加载完成',
              loadReadyText: '释放加载',
              loadingText: '正在加载...',
              loadFailedText: '加载失败',
              noMoreText: '没有更多',
              infoText: '更新于 %T'
          ),
          onRefresh: () async{
            await Future.delayed(Duration(milliseconds: 1000));
            //刷新的时候清除数据
            dataList.clear();
            page = 1;
            mockNetworkData(context);

          },
          onLoad: () async{
            await Future.delayed(Duration(milliseconds: 1000));
            page++;
            mockNetworkData(context);
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    var model = dataList[index];
    return InkWell(
      onTap: () {
        //FadeRoute是自定义的切换过度动画（渐隐渐现） 如果不需要 可以使用默认的MaterialPageRoute
        Navigator.of(context).push(new FadeRoute(page: PhotoGalleryPage(
          images:model.images,//传入图片list
          model: model,
          index: index,//传入当前点击的图片的index
          heroTag: model.images[0],//传入当前点击的图片的hero tag （可选）
        )));
      },
      child: CachedNetworkImage(
        imageUrl: model.images[0],
        placeholder: (context, url) =>
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              width: 100.0,
              height: 90.0,
            ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }

  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    Get.find<GankPageController>().getGank(page.toString());
    //g.getGank(page.toString());
    return "end";
  }

}