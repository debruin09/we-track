import 'package:flutter/material.dart';
import 'package:we_track/shared/themes.dart/themes.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200.0,
                height: 250.0,
                child: Image.asset(
                  "assets/images/icon.png",
                  fit: BoxFit.fill,
                )),
            const SizedBox(height: 10.0),
            Text("We Track",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
