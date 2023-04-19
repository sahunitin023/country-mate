// ignore_for_file: library_private_types_in_public_api

import 'package:country_mate/essentials/settings_data.dart';
import 'package:country_mate/widgets/big_font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_mate/essentials/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool displayCurrency = Provider.of<SettingsData>(context).displayCurrency;
    bool displayWeather = Provider.of<SettingsData>(context).displayWeather;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                activeTrackColor: const Color.fromARGB(167, 255, 193, 7),
                activeColor: Colors.amber,
                inactiveTrackColor: const Color.fromARGB(92, 31, 63, 241),
                title: BigFont(
                  text: 'Weather',
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w700,
                ),
                value: displayWeather,
                onChanged: (value) {
                  Provider.of<SettingsData>(context, listen: false)
                      .changeDisplayWeather(value);
                },
              ),
              SwitchListTile(
                activeTrackColor: const Color.fromARGB(167, 255, 193, 7),
                activeColor: Colors.amber,
                inactiveTrackColor: const Color.fromARGB(92, 31, 63, 241),
                title: BigFont(
                  text: 'Currency',
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w700,
                ),
                value: displayCurrency,
                onChanged: (value) {
                  Provider.of<SettingsData>(context, listen: false)
                      .changeDisplayCurrency(value);
                },
              ),
              const SizedBox(height: 30.0),
              BigFont(
                text: 'Select Country',
                textAlign: TextAlign.left,
                fontWeight: FontWeight.w700,
              ),
              DropdownButton<String>(
                borderRadius: BorderRadius.circular(20.0),
                dropdownColor: kContainerBGColor,
                value: Provider.of<SettingsData>(context).selectedCountry,
                onChanged: (value) {
                  Provider.of<SettingsData>(context, listen: false)
                      .changeSelectedCountry(value!);
                },
                items: [
                  'United States',
                  'United Kingdom',
                  'UAE',
                  'India',
                  'Japan',
                  'Russia',
                  'Canada',
                ].map(
                  (country) {
                    return DropdownMenuItem<String>(
                      onTap: () {},
                      value: country,
                      child: Center(
                        child: BigFont(
                          text: country,
                          size: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
