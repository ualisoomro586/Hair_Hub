// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hair_hub/barber_signup.dart';
import 'package:hair_hub/customer_signup.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Hair Hub",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF404040),
        ),
        body: orientation == Orientation.portrait
            ? Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(245, 246, 250, 255),
                  Color.fromARGB(226, 228, 246, 255)
                ])),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/logo1.png',
                          width: width * 0.75,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 0.01,
                        ),
                        Text(
                          "Register as:",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => sign_up(value: ""),
                                  ));
                            },
                            child:
                                Text("Barber", style: TextStyle(fontSize: 20)),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.85, height * 0.07),
                              shape: StadiumBorder(),
                              backgroundColor: Color(0xFF404040),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => sign_up2(),
                                  ));
                            },
                            child: Text(
                              "Customer",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.85, height * 0.07),
                              shape: StadiumBorder(),
                              backgroundColor: Color(0xFFECB72B),
                            ))
                      ]),
                ),
              )
            : Container(
                height: height * 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(245, 246, 250, 255),
                  Color.fromARGB(226, 228, 246, 255)
                ])),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo1.png'),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Login with your data that you have entered during Your registration",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text("Sign Up",
                                  style: TextStyle(fontSize: 20)),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(width * 0.7, 50),
                                  shape: StadiumBorder(),
                                  backgroundColor: Colors.blue[600])),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Sign in",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width * 0.7, 50),
                                shape: StadiumBorder(),
                                backgroundColor: Colors.amber[400],
                              ))
                        ]),
                  ),
                ),
              ));
  }
}
