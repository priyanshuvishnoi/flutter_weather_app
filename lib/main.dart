import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'Widgets/WeatherDataList.dart';
import 'Widgets/Header.dart';
import './key.dart' as key;

void main() => runApp(
      MaterialApp(
        title: 'Weather App',
        home: Home(),
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.cyan,
        ),
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var humidity;
  var feeltemp;
  var name;
  var visibility;
  var minTemp;
  var maxTemp;
  var results1;
  var results2;
  bool loading = true;

  String latitude = "";
  String longitude = "";
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future _getCurrentLocation() async {
    final geoPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      latitude = '${geoPosition.latitude}';
      longitude = '${geoPosition.longitude}';
    });
  }

  Future _getWeather() async {
    await _getCurrentLocation();
    http.Response response1 = await http.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,hourly&appid=${key.apiKey}');

    http.Response response2 = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${key.apiKey}');
    results1 = jsonDecode(response1.body);
    results2 = jsonDecode(response2.body);
    setState(() {
      loading = false;
      name = results2['name'] == '' ? '--' : results2['name'];
      visibility = results1['current']['visibility'];
      temp = (results1['current']['temp'] - 273.15).round();
      feeltemp = (results1['current']['feels_like'] - 273.15).round();
      minTemp = (results1['daily'][0]['temp']['min'] - 273.15).round();
      maxTemp = (results1['daily'][0]['temp']['max'] - 273.15).round();
      humidity = results1['current']['humidity'];
      description = results1['current']['weather'][0]['description'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.blue,
            ],
          ),
        ),
        child: Column(
          children: [
            Header(
              description: description,
              name: name,
              temp: temp,
            ),
            WeatherDataList(
              feeltemp: feeltemp,
              humidity: humidity,
              maxTemp: maxTemp,
              minTemp: minTemp,
              temp: temp,
              visibility: visibility,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 2, 128, 163),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {
          setState(() {
            loading = true;
          });
          _getWeather();
        },
        label: loading ? Text('') : Text('Refresh'),
        icon: loading
            ? Center(
                child: Row(
                  children: [
                    Text('   '),
                    CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        )),
                  ],
                ),
              )
            : Icon(Icons.refresh),
      ),
    );
  }
}
