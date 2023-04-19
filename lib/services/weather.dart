import '../services/networking.dart';
import '../services/location.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String countryName) async {
    Location location = Location();
    double latitude = location.getLatitude(countryName);
    double longitude = Location().getLongitude(countryName);
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&daily=&timezone=IST&forecast_days=8&current_weather=true');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<int> returnCurrentTemp(String countryName) async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather(countryName);
    if (weatherData == null) {
      return 0;
    } else {
      double temp = weatherData['current_weather']['temperature'];
      return temp.toInt();
    }
  }

  Future<int> returnForecastTemp(String countryName, int index) async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather(countryName);
    if (weatherData == null) {
      return 0;
    } else {
      double temp = weatherData['hourly']['temperature_2m'][index * 24];
      return temp.toInt();
    }
  }
}
