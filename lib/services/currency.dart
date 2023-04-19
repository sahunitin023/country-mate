import 'package:country_mate/services/networking.dart';
import 'location.dart';

class CurrencyModel {
  Future<dynamic> getCurrencyInfo(String countryName) async {
    String currencyCode = Location().getCurrencyCode(countryName);
    NetworkHelper networkHelper = NetworkHelper(
        'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$currencyCode/inr.json');
    var currencyData = await networkHelper.getData();
    return currencyData;
  }

  Future<double> returnCurrencyPrice(String? countryName) async {
    CurrencyModel currencyModel = CurrencyModel();
    var currencyData = await currencyModel.getCurrencyInfo(countryName!);
    double price = currencyData['inr'];
    return price;
  }
}
