import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/model/gank_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


// ignore: must_be_immutable
class PhotoGalleryPage extends StatefulWidget {
  Data model;
  List images=[];
  int index=0;
  String heroTag;
  PageController controller;

  PhotoGalleryPage({Key key,@required this.images,this.model,this.index,this.controller,this.heroTag}) : super(key: key){
    controller=PageController(initialPage: index);
  }

  @override
  _PhotoGalleryPageState createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  int currentIndex=0;

  @override
  void initState() {
    super.initState();
    currentIndex=widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.images[index]),
                      heroAttributes: widget.heroTag.isNotEmpty?PhotoViewHeroAttributes(tag: widget.heroTag):null,
                    );
                  },
                  itemCount: widget.images.length,
                  //loadingBuilder: buildLoading(context),
                  backgroundDecoration: null,
                  pageController: widget.controller,
                  enableRotation: true,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex=index;
                    });
                  },
                )
            ),
          ),
          Positioned(//图片index显示
            top: MediaQuery.of(context).padding.top+15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex+1}/${widget.images.length}",style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
          Positioned(//右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(Icons.close,size: 30,color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.model.author != null ?
                  Text(
                    widget.model.author,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Courier',
                    ),
                  ):
                  Text("未知"),
                  widget.model.desc != null ?
                  Text(
                    widget.model.desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Courier',
                    ),
                  ):
                  Text("这个人很赖啥也没有写"),
                ],
              )
          )

        ],
      ),
    );
  }

  LoadingBuilder buildLoading(BuildContext context){
    //return Text(data);
  }


}