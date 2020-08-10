import 'dart:io';

class AdMobService{
  String getAdMobAppId(){
    if(Platform.isAndroid){
      return 'ca-app-pub-1439834229406384~3147753038';
    }
    return null;
  }

  String getBannerAdId(){
    if(Platform.isAndroid){
      return 'ca-app-pub-1439834229406384/7274700303';
      //return 'ca-app-pub-1439834229406384/3641140264';
    }
    return null;
  }

}