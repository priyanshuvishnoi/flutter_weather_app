import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:intl';
import 'package:geolocator/geolocator.dart';
import './key.dart' as key;

void main() => runApp(
      MaterialApp(
        title: 'Weather App',
        home: Home(),
        theme: ThemeData(
          brightness: Brightness.dark,
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
  var sunRise;
  var sunSet;
  String latitude = "";
  String longitude = "";
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future _getCurrentLocation() async {
    final geoPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(geoPosition.latitude);
    print(geoPosition.longitude);
    setState(() {
      latitude = '${geoPosition.latitude}';
      longitude = '${geoPosition.longitude}';
    });
    _getWeather();
  }

  Future _getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${key.apiKey}');

    var results = jsonDecode(response.body);
    print('data $results');
    setState(() {
      name = results['name'];
      visibility = results['visibility'];
      temp = (results['main']['temp'] - 273.15).round();
      feeltemp = (results['main']['feels_like'] - 273.15).round();
      minTemp = (results['main']['temp_min'] - 273.15).round();
      maxTemp = (results['main']['temp_max'] - 273.15).round();
      humidity = results['main']['humidity'];
      description = results['weather'][0]['description'];
      sunRise = results['sys']['sunrise'];
      sunSet = results['sys']['sunset'];
      // this.temp = results[0]['Temperature']['Metric']['Value'];
      // this.precipitaion = results[0]['HasPrecipitation'] ? 'Yes' : 'No';
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.blue],
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      name != null ? 'Currently in $name' : 'Loading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    temp != null ? '$temp\u00B0 C' : 'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      description != null ? '$description' : 'Loading',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.blue],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Feels like"),
                      trailing:
                          Text(feeltemp != null ? '$temp\u00B0 C' : 'Loading'),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.arrowAltCircleUp),
                      title: Text("Min Temp"),
                      trailing: Text(
                          minTemp != null ? '$minTemp\u00B0 C' : 'Loading'),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.arrowAltCircleDown),
                      title: Text("Max Temp"),
                      trailing: Text(
                          maxTemp != null ? '$maxTemp\u00B0 C' : 'Loading'),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloudRain),
                      title: Text("humidity"),
                      trailing:
                          Text(humidity != null ? '$humidity %' : 'Loading'),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.binoculars),
                      title: Text("visibility"),
                      trailing: Text(
                          visibility != null ? '$visibility m' : 'Loading'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
