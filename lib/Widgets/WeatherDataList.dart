import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherDataList extends StatelessWidget {
  final feeltemp;
  final temp;
  final minTemp;
  final humidity;
  final maxTemp;
  final visibility;
//hello world
  WeatherDataList({
    this.feeltemp,
    this.humidity,
    this.maxTemp,
    this.minTemp,
    this.temp,
    this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [.8, 1],
            colors: [
              Color(0xE1E6EdFF),
              Color(0xB9D4FAFF),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.thermometerHalf,
                  color: Colors.black,
                ),
                title: Text(
                  "Feels like",
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  feeltemp != null ? '$temp\u00B0 C' : 'Loading',
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.arrowAltCircleUp,
                  color: Colors.black,
                ),
                title: Text(
                  "Max Temp",
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  maxTemp != null ? '$maxTemp\u00B0 C' : 'Loading',
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.arrowAltCircleDown,
                  color: Colors.black,
                ),
                title: Text(
                  "Min Temp",
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  minTemp != null ? '$minTemp\u00B0 C' : 'Loading',
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.cloudRain,
                  color: Colors.black,
                ),
                title: Text(
                  "humidity",
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  humidity != null ? '$humidity %' : 'Loading',
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.binoculars,
                  color: Colors.black,
                ),
                title: Text(
                  "visibility",
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  visibility == null
                      ? 'Loading'
                      : visibility != 10000
                          ? '$visibility m'
                          : 'Not Available',
                  style: TextStyle(
                    color: Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
