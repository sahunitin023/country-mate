// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:intl/intl.dart';
import 'package:country_mate/essentials/constants.dart';
import 'package:country_mate/essentials/settings_data.dart';
import 'package:country_mate/services/currency.dart';
import 'package:country_mate/services/location.dart';
import 'package:country_mate/services/weather.dart';
import 'package:country_mate/widgets/big_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String selectedCountry =
        Provider.of<SettingsData>(context, listen: false).selectedCountry;
    updateUI(selectedCountry);
  }

  void updateUI(String selectedCountry) async {
    try {
      WeatherModel weatherModel = WeatherModel();
      CurrencyModel currencyModel = CurrencyModel();
      int currentTemp = await weatherModel.returnCurrentTemp(selectedCountry);
      List<int> forecastTemp = [
        await weatherModel.returnForecastTemp(selectedCountry, 1),
        await weatherModel.returnForecastTemp(selectedCountry, 2),
        await weatherModel.returnForecastTemp(selectedCountry, 3),
        await weatherModel.returnForecastTemp(selectedCountry, 4),
        await weatherModel.returnForecastTemp(selectedCountry, 5),
        await weatherModel.returnForecastTemp(selectedCountry, 6),
        await weatherModel.returnForecastTemp(selectedCountry, 7),
      ];
      double currencyrate;
      if (selectedCountry == 'India') {
        currencyrate = 1.000;
      } else {
        currencyrate = await currencyModel.returnCurrencyPrice(selectedCountry);
      }
      Provider.of<SettingsData>(context, listen: false)
          .changeCurrTemp(currentTemp);
      Provider.of<SettingsData>(context, listen: false)
          .changeCurrencyRate(currencyrate);
      Provider.of<SettingsData>(context, listen: false)
          .changeForecastTemp(forecastTemp);
    } catch (e) {
      print(e);
    }
    // setState(() {
    //   showSpinner = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // bool showCurrency = Provider.of<SettingsData>(context).displayCurrency;
    // bool showWeather = Provider.of<SettingsData>(context).displayWeather;
    // String selectedCountry = Provider.of<SettingsData>(context).selectedCountry;
    // int currentTemperature =
    //     Provider.of<SettingsData>(context).currentTemperature;
    // List<int> forecastTemperature =
    //     Provider.of<SettingsData>(context).forecastTemperature;
    // double currencyRate = Provider.of<SettingsData>(context).currencyRate;

    return Consumer<SettingsData>(
      builder: (context, settingsData, child) {
        bool showCurrency = settingsData.displayCurrency;
        bool showWeather = settingsData.displayWeather;
        String selectedCountry = settingsData.selectedCountry;
        int currentTemperature = settingsData.currentTemperature;
        List<int> forecastTemperature = settingsData.forecastTemperature;
        double currencyRate = settingsData.currencyRate;

        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: buildBody(selectedCountry, showCurrency, showWeather,
                currentTemperature, forecastTemperature, currencyRate),
          ),
        );
      },
    );
  }

  Widget buildBody(
      String selectedCountry,
      bool showCurrency,
      bool showWeather,
      int currentTemperature,
      List<int> forecastTemperature,
      double currencyRate) {
    // updateUI(selectedCountry);
    if (showCurrency && showWeather) {
      // print(selectedCountry);
      return DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    child: BigFont(
                      text: 'Weather',
                      size: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Tab(
                    child: BigFont(
                      text: 'Currency',
                      size: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // Weather tab content
                  weatherTab(selectedCountry, currentTemperature,
                      forecastTemperature), // Currency tab content
                  currencyTab(selectedCountry, currencyRate),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (showWeather) {
      // print(selectedCountry);
      return DefaultTabController(
        length: 1,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'Weather',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // Weather tab content
                  weatherTab(
                      selectedCountry, currentTemperature, forecastTemperature),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (showCurrency) {
      // print(selectedCountry);
      return DefaultTabController(
        length: 1,
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'Currency',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  // Currency tab content
                  currencyTab(selectedCountry, currencyRate),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget currencyTab(String selectedCountry, double currencyRate) {
    String currencyCode =
        Location().getCurrencyCode(selectedCountry).toUpperCase();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigFont(
            text: selectedCountry,
            fontWeight: FontWeight.w800,
            size: 50.0,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(
            height: 30.0,
          ),
          BigFont(
            text: '1 $currencyCode = ${currencyRate.toStringAsFixed(3)} INR',
            fontWeight: FontWeight.w900,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget weatherTab(
      String selectedCountry, int currTemp, List<int> forecastTemp) {
    String cityName = Location().getCity(selectedCountry);
    var mediaQuery = MediaQuery.of(context);
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('E, d MMM').format(date);
    List<String> weatherEmoji = ['🌦️', '☁️', '🌥️', '☀️', '🌨️', '🌤️', '🌧️'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.03,
          ),
          Container(
            height: mediaQuery.size.height * 0.3,
            decoration: BoxDecoration(
              color: kContainerBGColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today',
                          style: GoogleFonts.poppins(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Baseline(
                          baseline: 50,
                          baselineType: TextBaseline.alphabetic,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Baseline(
                                baseline: 30,
                                baselineType: TextBaseline.alphabetic,
                                child: BigFont(
                                  text: '$currTemp',
                                  color: Colors.white,
                                  size: 70.0,
                                ),
                              ),
                              Baseline(
                                baseline: 10,
                                baselineType: TextBaseline.alphabetic,
                                child: BigFont(
                                  text: '°C',
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w600,
                                  size: 40.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Baseline(
                          baseline: 50,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(
                            '🌤️',
                            style: TextStyle(fontSize: 60.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/location.png',
                          color: kSecondaryColor,
                          height: 25.0,
                        ),
                        BigFont(
                          text: ' $cityName, $selectedCountry',
                          size: 15.0,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.06,
          ),
          Text(
            'Weather Forecast',
            style: GoogleFonts.poppins(
              fontSize: 25.0,
              color: Colors.grey.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.03,
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.19,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                7,
                (index) {
                  final dateIndex = date.add(Duration(days: index + 1));
                  final DateFormat dFormatter = DateFormat('dd MMM');
                  final String forecastDate = dFormatter.format(dateIndex);
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      width: mediaQuery.size.width * 0.33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kContainerBGColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                weatherEmoji[index],
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 45.0),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: BigFont(
                                textAlign: TextAlign.left,
                                text: forecastDate,
                                size: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BigFont(
                                    text: '${forecastTemp[index]}',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade300,
                                    size: 35.0,
                                  ),
                                  BigFont(
                                    text: ' °C',
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
