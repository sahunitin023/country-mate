import 'package:country_mate/essentials/constants.dart';
import 'package:country_mate/essentials/settings_data.dart';
import 'package:country_mate/screens/settings.dart';
import 'package:country_mate/widgets/big_font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const CountryMate());
}

class CountryMate extends StatefulWidget {
  const CountryMate({super.key});

  @override
  State<CountryMate> createState() => _CountryMateState();
}

class _CountryMateState extends State<CountryMate> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const Placeholder(),
    const SettingsScreen(),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 10.0,
                backgroundColor: kPrimaryColor,
                title: Center(
                  child: BigFont(
                    text: 'Country Mate',
                    fontWeight: FontWeight.w800,
                    size: 25.0,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              body: _pages[_selectedIndex],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 15.0, left: 20.0, right: 20.0),
                child: PhysicalModel(
                  elevation: 8.0,
                  color: kSecondaryColor,
                  shadowColor: kSecondaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kSecondaryColor,
                      //border: Border.all(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: BottomNavigationBar(
                        currentIndex: _selectedIndex,
                        onTap: _onItemTapped,
                        // unselectedItemColor:
                        //     const Color.fromARGB(255, 25, 3, 111),
                        selectedItemColor: kPrimaryColor,
                        selectedLabelStyle: GoogleFonts.spinnaker(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 10.0),
                        ),
                        showUnselectedLabels: false,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            backgroundColor: kSecondaryColor,
                            icon: Image.asset(
                              _selectedIndex == 0
                                  ? 'images/home_solid.png'
                                  : 'images/home.png',
                              height: 35,
                              color: _selectedIndex == 0
                                  ? kPrimaryColor
                                  : const Color.fromARGB(155, 74, 61, 255),
                            ),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: kSecondaryColor,
                            icon: Image.asset(
                              'images/search.png',
                              height: 35,
                              color: _selectedIndex == 1
                                  ? kPrimaryColor
                                  : const Color.fromARGB(155, 74, 61, 255),
                            ),
                            label: 'Search',
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: kSecondaryColor,
                            icon: Image.asset(
                              _selectedIndex == 2
                                  ? 'images/settings_solid.png'
                                  : 'images/settings.png',
                              height: 35,
                              color: _selectedIndex == 2
                                  ? kPrimaryColor
                                  : const Color.fromARGB(155, 74, 61, 255),
                            ),
                            label: 'Settings',
                          ),
                          BottomNavigationBarItem(
                            backgroundColor: kSecondaryColor,
                            icon: Image.asset(
                              _selectedIndex == 3
                                  ? 'images/profile_solid.png'
                                  : 'images/profile.png',
                              height: 35,
                              color: _selectedIndex == 3
                                  ? kPrimaryColor
                                  : const Color.fromARGB(155, 74, 61, 255),
                            ),
                            label: 'Profile',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
