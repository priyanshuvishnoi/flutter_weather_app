import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final name;
  final description;
  final temp;

  Header({
    this.description,
    this.name,
    this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(250, 80),
          bottomRight: Radius.elliptical(250, 80),
        ),
        
      ),
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      
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
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.black,
                      offset: Offset(0, 0),
                    ),
                  ],
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              temp != null ? '$temp\u00B0 C' : 'Loading',
              style: TextStyle(
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(0, 0),
                  ),
                ],
                fontSize: 48,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                description != null ? '$description' : 'Loading',
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.black,
                      offset: Offset(0, 0),
                    ),
                  ],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
