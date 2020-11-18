import 'dart:convert';


// class WeatherModel {
//   WeatherModel({
//     this.heWeather6,
//   });
//
//   List<HeWeather6> heWeather6;
//
//   factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
//     heWeather6: List<HeWeather6>.from(json["HeWeather6"].map((x) => HeWeather6.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "HeWeather6": List<dynamic>.from(heWeather6.map((x) => x.toJson())),
//   };
//
// }
//
// class HeWeather6 {
//   HeWeather6({
//     this.basic,
//     this.update,
//     this.status,
//     this.now,
//     this.dailyForecast,
//     this.hourly,
//     this.lifestyle,
//   });
//
//   Basic basic;
//   Update update;
//   String status;
//   Now now;
//   List<DailyForecast> dailyForecast;
//   List<Now> hourly;
//   List<Lifestyle> lifestyle;
//
//   factory HeWeather6.fromJson(Map<String, dynamic> json) => HeWeather6(
//     basic: Basic.fromJson(json["basic"]),
//     update: Update.fromJson(json["update"]),
//     status: json["status"],
//     now: Now.fromJson(json["now"]),
//     dailyForecast: List<DailyForecast>.from(json["daily_forecast"].map((x) => DailyForecast.fromJson(x))),
//     hourly: List<Now>.from(json["hourly"].map((x) => Now.fromJson(x))),
//     lifestyle: List<Lifestyle>.from(json["lifestyle"].map((x) => Lifestyle.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "basic": basic.toJson(),
//     "update": update.toJson(),
//     "status": status,
//     "now": now.toJson(),
//     "daily_forecast": List<dynamic>.from(dailyForecast.map((x) => x.toJson())),
//     "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
//     "lifestyle": List<dynamic>.from(lifestyle.map((x) => x.toJson())),
//   };
// }
//
// class Basic {
//   Basic({
//     this.cid,
//     this.location,
//     this.parentCity,
//     this.adminArea,
//     this.cnty,
//     this.lat,
//     this.lon,
//     this.tz,
//   });
//
//   String cid;
//   String location;
//   String parentCity;
//   String adminArea;
//   String cnty;
//   String lat;
//   String lon;
//   String tz;
//
//   factory Basic.fromJson(Map<String, dynamic> json) => Basic(
//     cid: json["cid"],
//     location: json["location"],
//     parentCity: json["parent_city"],
//     adminArea: json["admin_area"],
//     cnty: json["cnty"],
//     lat: json["lat"],
//     lon: json["lon"],
//     tz: json["tz"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cid": cid,
//     "location": location,
//     "parent_city": parentCity,
//     "admin_area": adminArea,
//     "cnty": cnty,
//     "lat": lat,
//     "lon": lon,
//     "tz": tz,
//   };
// }
//
// class DailyForecast {
//   DailyForecast({
//     this.condCodeD,
//     this.condCodeN,
//     this.condTxtD,
//     this.condTxtN,
//     this.date,
//     this.hum,
//     this.mr,
//     this.ms,
//     this.pcpn,
//     this.pop,
//     this.pres,
//     this.sr,
//     this.ss,
//     this.tmpMax,
//     this.tmpMin,
//     this.uvIndex,
//     this.vis,
//     this.windDeg,
//     this.windDir,
//     this.windSc,
//     this.windSpd,
//   });
//
//   String condCodeD;
//   String condCodeN;
//   String condTxtD;
//   String condTxtN;
//   String date;
//   String hum;
//   String mr;
//   String ms;
//   String pcpn;
//   String pop;
//   String pres;
//   String sr;
//   String ss;
//   String tmpMax;
//   String tmpMin;
//   String uvIndex;
//   String vis;
//   String windDeg;
//   String windDir;
//   String windSc;
//   String windSpd;
//
//   factory DailyForecast.fromJson(Map<String, dynamic> json) => DailyForecast(
//     condCodeD: json["cond_code_d"],
//     condCodeN: json["cond_code_n"],
//     condTxtD: json["cond_txt_d"],
//     condTxtN: json["cond_txt_n"],
//     date: json["date"],
//     hum: json["hum"],
//     mr: json["mr"],
//     ms: json["ms"],
//     pcpn: json["pcpn"],
//     pop: json["pop"],
//     pres: json["pres"],
//     sr: json["sr"],
//     ss: json["ss"],
//     tmpMax: json["tmp_max"],
//     tmpMin: json["tmp_min"],
//     uvIndex: json["uv_index"],
//     vis: json["vis"],
//     windDeg: json["wind_deg"],
//     windDir: json["wind_dir"],
//     windSc: json["wind_sc"],
//     windSpd: json["wind_spd"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cond_code_d": condCodeD,
//     "cond_code_n": condCodeN,
//     "cond_txt_d": condTxtD,
//     "cond_txt_n": condTxtN,
//     //"${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"
//     "date": date,
//     "hum": hum,
//     "mr": mr,
//     "ms": ms,
//     "pcpn": pcpn,
//     "pop": pop,
//     "pres": pres,
//     "sr": sr,
//     "ss": ss,
//     "tmp_max": tmpMax,
//     "tmp_min": tmpMin,
//     "uv_index": uvIndex,
//     "vis": vis,
//     "wind_deg": windDeg,
//     "wind_dir": windDir,
//     "wind_sc": windSc,
//     "wind_spd": windSpd,
//   };
// }
//
// class Now {
//   Now({
//     this.cloud,
//     this.condCode,
//     this.condTxt,
//     this.dew,
//     this.hum,
//     this.pop,
//     this.pres,
//     this.time,
//     this.tmp,
//     this.windDeg,
//     this.windDir,
//     this.windSc,
//     this.windSpd,
//     this.fl,
//     this.pcpn,
//     this.vis,
//   });
//
//   String cloud;
//   String condCode;
//   String condTxt;
//   String dew;
//   String hum;
//   String pop;
//   String pres;
//   String time;
//   String tmp;
//   String windDeg;
//   String windDir;
//   String windSc;
//   String windSpd;
//   String fl;
//   String pcpn;
//   String vis;
//
//   factory Now.fromJson(Map<String, dynamic> json) => Now(
//     cloud: json["cloud"],
//     condCode: json["cond_code"],
//     condTxt: json["cond_txt"],
//     dew: json["dew"] == null ? null : json["dew"],
//     hum: json["hum"],
//     pop: json["pop"] == null ? null : json["pop"],
//     pres: json["pres"],
//     time: json["time"] == null ? null : json["time"],
//     tmp: json["tmp"],
//     windDeg: json["wind_deg"],
//     windDir: json["wind_dir"],
//     windSc: json["wind_sc"],
//     windSpd: json["wind_spd"],
//     fl: json["fl"] == null ? null : json["fl"],
//     pcpn: json["pcpn"] == null ? null : json["pcpn"],
//     vis: json["vis"] == null ? null : json["vis"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cloud": cloud,
//     "cond_code": condCode,
//     "cond_txt": condTxt,
//     "dew": dew == null ? null : dew,
//     "hum": hum,
//     "pop": pop == null ? null : pop,
//     "pres": pres,
//     "time": time == null ? null : time,
//     "tmp": tmp,
//     "wind_deg": windDeg,
//     "wind_dir": windDir,
//     "wind_sc": windSc,
//     "wind_spd": windSpd,
//     "fl": fl == null ? null : fl,
//     "pcpn": pcpn == null ? null : pcpn,
//     "vis": vis == null ? null : vis,
//   };
// }
//
// class Lifestyle {
//   Lifestyle({
//     this.type,
//     this.brf,
//     this.txt,
//   });
//
//   String type;
//   String brf;
//   String txt;
//
//   factory Lifestyle.fromJson(Map<String, dynamic> json) => Lifestyle(
//     type: json["type"],
//     brf: json["brf"],
//     txt: json["txt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "brf": brf,
//     "txt": txt,
//   };
// }
//
// class Update {
//   Update({
//     this.loc,
//     this.utc,
//   });
//
//   String loc;
//   String utc;
//
//   factory Update.fromJson(Map<String, dynamic> json) => Update(
//     loc: json["loc"],
//     utc: json["utc"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "loc": loc,
//     "utc": utc,
//   };
// }


class WeatherModel {
  List<HeWeather6> heWeather6;

  WeatherModel({this.heWeather6});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['HeWeather6'] != null) {
      heWeather6 = new List<HeWeather6>();
      json['HeWeather6'].forEach((v) {
        heWeather6.add(new HeWeather6.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.heWeather6 != null) {
      data['HeWeather6'] = this.heWeather6.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeWeather6 {
  Basic basic;
  Update update;
  String status;
  Now now;
  List<DailyForecast> dailyForecast;
  List<Hourly> hourly;
  List<Lifestyle> lifestyle;

  HeWeather6(
      {this.basic,
        this.update,
        this.status,
        this.now,
        this.dailyForecast,
        this.hourly,
        this.lifestyle});

  HeWeather6.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    update =
    json['update'] != null ? new Update.fromJson(json['update']) : null;
    status = json['status'];
    now = json['now'] != null ? new Now.fromJson(json['now']) : null;
    if (json['daily_forecast'] != null) {
      dailyForecast = new List<DailyForecast>();
      json['daily_forecast'].forEach((v) {
        dailyForecast.add(new DailyForecast.fromJson(v));
      });
    }
    if (json['hourly'] != null) {
      hourly = new List<Hourly>();
      json['hourly'].forEach((v) {
        hourly.add(new Hourly.fromJson(v));
      });
    }
    if (json['lifestyle'] != null) {
      lifestyle = new List<Lifestyle>();
      json['lifestyle'].forEach((v) {
        lifestyle.add(new Lifestyle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['basic'] = this.basic.toJson();
    }
    if (this.update != null) {
      data['update'] = this.update.toJson();
    }
    data['status'] = this.status;
    if (this.now != null) {
      data['now'] = this.now.toJson();
    }
    if (this.dailyForecast != null) {
      data['daily_forecast'] =
          this.dailyForecast.map((v) => v.toJson()).toList();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly.map((v) => v.toJson()).toList();
    }
    if (this.lifestyle != null) {
      data['lifestyle'] = this.lifestyle.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Basic {
  String cid;
  String location;
  String parentCity;
  String adminArea;
  String cnty;
  String lat;
  String lon;
  String tz;

  Basic(
      {this.cid,
        this.location,
        this.parentCity,
        this.adminArea,
        this.cnty,
        this.lat,
        this.lon,
        this.tz});

  Basic.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    location = json['location'];
    parentCity = json['parent_city'];
    adminArea = json['admin_area'];
    cnty = json['cnty'];
    lat = json['lat'];
    lon = json['lon'];
    tz = json['tz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['location'] = this.location;
    data['parent_city'] = this.parentCity;
    data['admin_area'] = this.adminArea;
    data['cnty'] = this.cnty;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['tz'] = this.tz;
    return data;
  }
}

class Update {
  String loc;
  String utc;

  Update({this.loc, this.utc});

  Update.fromJson(Map<String, dynamic> json) {
    loc = json['loc'];
    utc = json['utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loc'] = this.loc;
    data['utc'] = this.utc;
    return data;
  }
}

class Now {
  String cloud;
  String condCode;
  String condTxt;
  String fl;
  String hum;
  String pcpn;
  String pres;
  String tmp;
  String vis;
  String windDeg;
  String windDir;
  String windSc;
  String windSpd;

  Now(
      {this.cloud,
        this.condCode,
        this.condTxt,
        this.fl,
        this.hum,
        this.pcpn,
        this.pres,
        this.tmp,
        this.vis,
        this.windDeg,
        this.windDir,
        this.windSc,
        this.windSpd});

  Now.fromJson(Map<String, dynamic> json) {
    cloud = json['cloud'];
    condCode = json['cond_code'];
    condTxt = json['cond_txt'];
    fl = json['fl'];
    hum = json['hum'];
    pcpn = json['pcpn'];
    pres = json['pres'];
    tmp = json['tmp'];
    vis = json['vis'];
    windDeg = json['wind_deg'];
    windDir = json['wind_dir'];
    windSc = json['wind_sc'];
    windSpd = json['wind_spd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cloud'] = this.cloud;
    data['cond_code'] = this.condCode;
    data['cond_txt'] = this.condTxt;
    data['fl'] = this.fl;
    data['hum'] = this.hum;
    data['pcpn'] = this.pcpn;
    data['pres'] = this.pres;
    data['tmp'] = this.tmp;
    data['vis'] = this.vis;
    data['wind_deg'] = this.windDeg;
    data['wind_dir'] = this.windDir;
    data['wind_sc'] = this.windSc;
    data['wind_spd'] = this.windSpd;
    return data;
  }
}

class DailyForecast {
  String condCodeD;
  String condCodeN;
  String condTxtD;
  String condTxtN;
  String date;
  String hum;
  String mr;
  String ms;
  String pcpn;
  String pop;
  String pres;
  String sr;
  String ss;
  String tmpMax;
  String tmpMin;
  String uvIndex;
  String vis;
  String windDeg;
  String windDir;
  String windSc;
  String windSpd;

  DailyForecast(
      {this.condCodeD,
        this.condCodeN,
        this.condTxtD,
        this.condTxtN,
        this.date,
        this.hum,
        this.mr,
        this.ms,
        this.pcpn,
        this.pop,
        this.pres,
        this.sr,
        this.ss,
        this.tmpMax,
        this.tmpMin,
        this.uvIndex,
        this.vis,
        this.windDeg,
        this.windDir,
        this.windSc,
        this.windSpd});

  DailyForecast.fromJson(Map<String, dynamic> json) {
    condCodeD = json['cond_code_d'];
    condCodeN = json['cond_code_n'];
    condTxtD = json['cond_txt_d'];
    condTxtN = json['cond_txt_n'];
    date = json['date'];
    hum = json['hum'];
    mr = json['mr'];
    ms = json['ms'];
    pcpn = json['pcpn'];
    pop = json['pop'];
    pres = json['pres'];
    sr = json['sr'];
    ss = json['ss'];
    tmpMax = json['tmp_max'];
    tmpMin = json['tmp_min'];
    uvIndex = json['uv_index'];
    vis = json['vis'];
    windDeg = json['wind_deg'];
    windDir = json['wind_dir'];
    windSc = json['wind_sc'];
    windSpd = json['wind_spd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cond_code_d'] = this.condCodeD;
    data['cond_code_n'] = this.condCodeN;
    data['cond_txt_d'] = this.condTxtD;
    data['cond_txt_n'] = this.condTxtN;
    data['date'] = this.date;
    data['hum'] = this.hum;
    data['mr'] = this.mr;
    data['ms'] = this.ms;
    data['pcpn'] = this.pcpn;
    data['pop'] = this.pop;
    data['pres'] = this.pres;
    data['sr'] = this.sr;
    data['ss'] = this.ss;
    data['tmp_max'] = this.tmpMax;
    data['tmp_min'] = this.tmpMin;
    data['uv_index'] = this.uvIndex;
    data['vis'] = this.vis;
    data['wind_deg'] = this.windDeg;
    data['wind_dir'] = this.windDir;
    data['wind_sc'] = this.windSc;
    data['wind_spd'] = this.windSpd;
    return data;
  }
}

class Hourly {
  String cloud;
  String condCode;
  String condTxt;
  String dew;
  String hum;
  String pop;
  String pres;
  String time;
  String tmp;
  String windDeg;
  String windDir;
  String windSc;
  String windSpd;

  Hourly(
      {this.cloud,
        this.condCode,
        this.condTxt,
        this.dew,
        this.hum,
        this.pop,
        this.pres,
        this.time,
        this.tmp,
        this.windDeg,
        this.windDir,
        this.windSc,
        this.windSpd});

  Hourly.fromJson(Map<String, dynamic> json) {
    cloud = json['cloud'];
    condCode = json['cond_code'];
    condTxt = json['cond_txt'];
    dew = json['dew'];
    hum = json['hum'];
    pop = json['pop'];
    pres = json['pres'];
    time = json['time'];
    tmp = json['tmp'];
    windDeg = json['wind_deg'];
    windDir = json['wind_dir'];
    windSc = json['wind_sc'];
    windSpd = json['wind_spd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cloud'] = this.cloud;
    data['cond_code'] = this.condCode;
    data['cond_txt'] = this.condTxt;
    data['dew'] = this.dew;
    data['hum'] = this.hum;
    data['pop'] = this.pop;
    data['pres'] = this.pres;
    data['time'] = this.time;
    data['tmp'] = this.tmp;
    data['wind_deg'] = this.windDeg;
    data['wind_dir'] = this.windDir;
    data['wind_sc'] = this.windSc;
    data['wind_spd'] = this.windSpd;
    return data;
  }
}

class Lifestyle {
  String type;
  String brf;
  String txt;

  Lifestyle({this.type, this.brf, this.txt});

  Lifestyle.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    brf = json['brf'];
    txt = json['txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['brf'] = this.brf;
    data['txt'] = this.txt;
    return data;
  }
}