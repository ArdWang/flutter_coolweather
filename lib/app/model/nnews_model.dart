
class NnewsModel{
  /*"top3Images":[],
  "address":'',
  "time":0,
  "title":"",
  "id":0,
  "category":0*/

  int id;
  List<String> top3Images;
  String title;
  int category;
  String address;
  int time;

  NnewsModel({this.id, this.top3Images, this.title, this.category, this.address,this.time});

}

//
// class Top3Images{
//   String image;
//
//   Top3Images({this.image})
// }