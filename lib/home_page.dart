import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myntra_nav/widgets/cont_wid.dart';
import 'package:myntra_nav/widgets/search_bar.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  List<dynamic> countryData = [];
  String? selectedCountry;
  List<dynamic> stateData = [];
  String? selectedState;
  List<dynamic> cityData = [];
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCountries();
  }

  void loadCountries() async {
    String data = await rootBundle.loadString('country.json');
    setState(() {
      countryData = json.decode(data);
    });
  }

  void loadCity(String country, String state) async {
    List<dynamic> filtered = json
        .decode(await rootBundle.loadString('city.json'))
        .where((city) =>
            (city['country_name'] == country) && (city['state_name'] == state))
        .toList();
    setState(() {
      cityData = filtered;
    });
  }

  void loadState(String country) async {
    List<dynamic> filtered = json
        .decode(await rootBundle.loadString('states.json'))
        .where((state) => state['country_name'] == country)
        .toList();
    setState(() {
      stateData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'myntra_icon.png',
                  scale: 5,
                ),
                Text("MEN"),
                Text("WOMEN"),
                Text("KIDS"),
                Text("HOME & LIVING"),
                Text("BEAUTY"),
                Text("STUDIO"),
                search_bar(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Wrap(
                      runSpacing: 10,
                      verticalDirection: VerticalDirection.down,
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceEvenly,
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        icon_cont(
                            text: "Profile",
                            icon: Icons.account_circle_outlined),
                        icon_cont(text: "Wishlist", icon: Icons.heart_broken),
                        icon_cont(text: "Bag", icon: Icons.shopping_bag),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (countryData.isEmpty)
                ? CircularProgressIndicator()
                : Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Expanded(
                      child: DropdownButton(
                        hint: Text('Select a country'),
                        value: selectedCountry,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCountry = newValue;
                            selectedState = null;
                            loadState(selectedCountry!);
                          });
                        },
                        items: countryData
                            .map<DropdownMenuItem<dynamic>>((country) {
                          return DropdownMenuItem<dynamic>(
                            value: country['name'],
                            child: Text(country['name']),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            selectedCountry != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Expanded(
                      child: DropdownButton(
                        hint: Text('Select a state'),
                        value: selectedState,
                        onChanged: (newValue) {
                          setState(() {
                            selectedState = newValue;
                            selectedCity = null;
                            loadCity(selectedCountry!, selectedState!);
                          });
                        },
                        items: stateData.map<DropdownMenuItem<String>>((state) {
                          return DropdownMenuItem<String>(
                            value: state['name'],
                            child: Text(state['name']),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 20),

            selectedState != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Expanded(
                      child: DropdownButton(
                        hint: Text('Select a City'),
                        value: selectedCity,
                        onChanged: (newValue) {
                          setState(() {
                            selectedCity = newValue;
                          });
                        },
                        items: cityData.map<DropdownMenuItem<String>>((city) {
                          return DropdownMenuItem<String>(
                            value: city['name'],
                            child: Text(city['name']),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
