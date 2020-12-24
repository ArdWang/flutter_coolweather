class GankModel {
  List<Data> data;
  int page;
  int pageCount;
  int status;
  int totalCounts;

  GankModel(
      {this.data, this.page, this.pageCount, this.status, this.totalCounts});

  GankModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    page = json['page'];
    pageCount = json['page_count'];
    status = json['status'];
    totalCounts = json['total_counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['page_count'] = this.pageCount;
    data['status'] = this.status;
    data['total_counts'] = this.totalCounts;
    return data;
  }
}

class Data {
  String sId;
  String author;
  String category;
  String createdAt;
  String desc;
  List<String> images;
  int likeCounts;
  String publishedAt;
  int stars;
  String title;
  String type;
  String url;
  int views;

  Data(
      {this.sId,
        this.author,
        this.category,
        this.createdAt,
        this.desc,
        this.images,
        this.likeCounts,
        this.publishedAt,
        this.stars,
        this.title,
        this.type,
        this.url,
        this.views});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    category = json['category'];
    createdAt = json['createdAt'];
    desc = json['desc'];
    images = json['images'].cast<String>();
    likeCounts = json['likeCounts'];
    publishedAt = json['publishedAt'];
    stars = json['stars'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['images'] = this.images;
    data['likeCounts'] = this.likeCounts;
    data['publishedAt'] = this.publishedAt;
    data['stars'] = this.stars;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['views'] = this.views;
    return data;
  }
}