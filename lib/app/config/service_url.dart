
// 所有的接口地址

/*
  @author rnd
  2020 11/17 星期二
*/

// 获取天气的城市地址
const String APP_CITY_SERVICE_ADDRE = "http://guolin.tech/";

// 和风天气接口api
const String APP_WEATHER_SERVICE_ADDRE = "https://free-api.heweather.com/";

// 干货api接口
const String APP_GANK_SERVICE_ADDRE = "http://gank.io/";


const servicePath = {
  cityPageContent:'',
  weatherPageContent:'',
  gankPageContent:''
};

const String cityPageContent = 'cityPageContent';

const String weatherPageContent = 'weatherPageContent';

const String gankPageContent = 'gankPageContent';

// 服务接口对应的名称
const Map serviceName = {
  weatherPageContent:'天气页面',
  gankPageContent:'干货页面'
};

//获取服务器名称
String getServiceName(urlKey) {
  try {
    return serviceName[urlKey];
  } catch (e) {
    print('找不到接口名称');
    return '';
  }
}