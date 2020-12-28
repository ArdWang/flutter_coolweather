
class CountryModel{
  List<CountriesModel> data;

  CountryModel({this.data});

  CountryModel.fromJson(List<dynamic> json){
    if (json != null){
      data = List<CountriesModel>();
      json.map((b) {
        data.add(CountriesModel.fromJson(b));
      }).toList();
    }
  }

  List<CountriesModel> toJson(){
    List<dynamic> data = [];
    if (this.data != null) {
      data = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

}


class CountriesModel {

  int id;

  String name;

  CountriesModel({this.id, this.name});

  CountriesModel.fromJson(Map<String, dynamic> json) {
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
