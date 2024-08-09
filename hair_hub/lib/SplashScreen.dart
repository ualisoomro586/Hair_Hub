import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height * 10,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white, Colors.white])),
      child: Center(
        child: Image.asset(
          'assets/logo1.png', // Replace with the actual path to your image
          width: width * 0.7,
        ),
      ),
    ));
  }
}
