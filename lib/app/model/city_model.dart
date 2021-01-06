
class CityModel{

  List<CitiesModel> data;

  CityModel({this.data});

  CityModel.fromJson(List<dynamic> json){
    if (json != null){
      data = List<CitiesModel>();
      json.map((b) {
        data.add(CitiesModel.fromJson(b));
      }).toList();
    }
  }

  List<CitiesModel> toJson(){
    List<dynamic> data = [];
    if (this.data != null) {
      data = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

}


class CitiesModel {

  int id;

  String name;

  CitiesModel({this.id, this.name});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}