import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/gank_model.dart';
import 'package:flutter_coolweather/app/provider/gank_provider.dart';
import 'package:flutter_coolweather/app/utils/fade_route.dart';
import 'package:flutter_coolweather/app/widgets/load_state_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'gank/photo_gallery_page.dart';


/*
 * 错误显示
 * Flutter Incorrect use of ParentDataWidget
    提示报错，并且在release版本下无法显示界面，找到原因是使用了**Expanded**控件，

    经过排查后发现是Expanded、Flexible等组件，在“Container、Padding、Stack”组件中导致的。

    切记：Expanded、Flexible只在Row、Column等组件内，不在其他组件内使用。
 */

// ignore: must_be_immutable
class GankPage extends StatelessWidget{

  // 默认page = 1
  var page = 1;

  //页面加载状态，默认为加载中
  var _layoutState = LoadState.State_Loading;

  GankModel gankModel;

  //data 列表
  List<Data> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('福利'),
      ),

      // 使用静态还是动态？
      body: FutureBuilder(
        future: mockNetworkData(context),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            gankModel = Provider.of<GankProvider>(context, listen: true).gankModel;
            return Container(
              child: gankModel != null ? _loadStateLayout(context):Text("正在加载数据..."),
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
    _layoutState = Provider.of<GankProvider>(context,listen: false).layoutState;
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

      //文字显示在下方
      /*child: Container(
        child: Column(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //model.author != null ? Text(model.author):Text("未知"),
                    //model.desc != null ? Text(model.desc):Text("这个人很赖啥也没有写"),
                  ],
                ),
            ),
          ],
        ),
      ),
    );*/


  // 获取网络数据
  Future<String> mockNetworkData(BuildContext context) async{
    await Provider.of<GankProvider>(context, listen: false).getGank(page.toString());
    return "end";
  }

}