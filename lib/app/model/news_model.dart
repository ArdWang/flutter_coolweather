class NewsModel {

  int code;
  String message;
  List<Data> data;

  NewsModel({this.code, this.message, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<News> news;
  int id;
  String address;
  String fname;
  int adate;
  String title;

  Data({this.news, this.id, this.address, this.fname, this.adate, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = new List<News>();
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
    id = json['id'];
    address = json['address'];
    fname = json['fname'];
    adate = json['adate'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['address'] = this.address;
    data['fname'] = this.fname;
    data['adate'] = this.adate;
    data['title'] = this.title;
    return data;
  }
}

class News {

  String c;
  String j;
  String jn;
  int p;

  News({this.c, this.j, this.jn, this.p});

  News.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    j = json['j'];
    jn = json['jn'];
    p = json['p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c'] = this.c;
    data['j'] = this.j;
    data['jn'] = this.jn;
    data['p'] = this.p;
    return data;
  }
}