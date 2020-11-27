import 'dart:ffi';

import 'package:flutter/material.dart';


/*
  自动把json数据生成model数据
  https://javiercbk.github.io/json_to_dart/
  国家的model数据
*/


class StateModel{

  List<ProvinceModel> data;

  StateModel({this.data});

  StateModel.fromJson(List<dynamic> json){
    if (json != null){
      data = List<ProvinceModel>();
      json.map((b) {
        data.add(ProvinceModel.fromJson(b));
      }).toList();
    }
  }

  List<ProvinceModel> toJson(){
    List<dynamic> data = [];
    if (this.data != null) {
      data = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

}


class ProvinceModel {

  int id;

  String name;

  ProvinceModel({this.id, this.name});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
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

// import 'dart:convert';
//
//
//
// class StateModel {
//
//   static List<StateModel> stateModelFromJson(String str) => List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));
//
//   static String stateModelToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//   StateModel({
//     this.id,
//     this.name,
//   });
//
//   int id;
//   String name;
//
//   factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
//
