// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherModel{
  var temp=0.0;
  var pressure=0.0;
  var humidity=0.0;
  var temp_max=0.0;
  var temp_min=0.0;
  var image = "";

  double get getTemp =>temp - 272.5;
  double get getMaxTemp => temp_max - 272.5;
  double get getMinTemp => temp_min - 272.5;
  double get getHumidity => humidity;
  double get getPressure=> pressure;
  String get getImage{ 
    if(temp-272.5<10){
      image="https://c1.wallpaperflare.com/preview/606/260/952/snow-winter-white-cold.jpg";
    }
    else{
      image="https://s.yimg.com/ny/api/res/1.2/4sYR1Hr1nxR.Y1TroPmR9g--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTExMzg-/https://s.yimg.com/uu/api/res/1.2/onBo0h8K7rdmlDrR2g_mUw--~B/aD0xMjAwO3c9Njc1O2FwcGlkPXl0YWNoeW9u/http://media.zenfs.com/en_US/News/BGR_News/c9cq3l5.jpg";
    }
    return image;}


  WeatherModel(this.temp, this.pressure, this.humidity, this.temp_max, this.temp_min);

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      json["temp"],
      json["pressure"],
      json["humidity"],
      json["temp_max"],
      json["temp_min"]
    );
  }
}