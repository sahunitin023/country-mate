// import 'package:country_mate/services/currency.dart';
// import 'package:country_mate/services/weather.dart';
import 'package:flutter/material.dart';

class SettingsData extends ChangeNotifier {
  bool displayWeather = true;
  bool displayCurrency = true;
  String selectedCountry = 'United States';

  int currentTemperature = 0;
  List<int> forecastTemperature = [0, 0, 0, 0, 0, 0, 0];
  double currencyRate = 0.0;
  dynamic weatherData;

  void changeDisplayWeather(bool isDislpayed) {
    displayWeather = isDislpayed;
    notifyListeners();
  }

  void changeDisplayCurrency(bool isDislpayed) {
    displayCurrency = isDislpayed;
    notifyListeners();
  }

  void changeSelectedCountry(String selectedCountry) {
    this.selectedCountry = selectedCountry;
    notifyListeners();
  }

  // void changeWeatherData(String selectedCountry) {
  //   WeatherModel weatherModel = WeatherModel();
  //   weatherData = weatherModel.getCityWeather(selectedCountry);
  //   notifyListeners();
  // }

  void changeCurrTemp(int currentTemperature) {
    this.currentTemperature = currentTemperature;
    notifyListeners();
  }

  void changeCurrencyRate(double currencyRate) {
    this.currencyRate = currencyRate;
    notifyListeners();
  }

  void changeForecastTemp(List<int> forecastTemperature) {
    this.forecastTemperature = forecastTemperature;
    notifyListeners();
  }
}
