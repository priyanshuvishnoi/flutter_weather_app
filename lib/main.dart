import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  var precipitaion;

  Future getWeather() async {
    http.Response response = await http.get(
        'http://dataservice.accuweather.com/currentconditions/v1/206678?apikey=${key.apiKey}');

    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results[0]['Temperature']['Metric']['Value'];
      this.description = results[0]['WeatherText'];
      this.precipitaion = results[0]['HasPrecipitation'] ? 'Yes' : 'No';
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Currently in Lucknow',
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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temparature"),
                    trailing: Text(temp != null ? '$temp\u00B0 C' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Weather"),
                    trailing:
                        Text(description != null ? '$description' : 'Loading'),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloudRain),
                    title: Text("Chance of Rain"),
                    trailing: Text(
                        precipitaion != null ? '$precipitaion' : 'Loading'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
