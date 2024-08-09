// import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:hair_hub/customer_signin.dart';
import 'package:hair_hub/dummy.dart';
import 'package:hair_hub/dummy2.dart';
import 'package:hair_hub/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hair_hub/forget_password.dart';
import 'package:hair_hub/hair_style.dart';
import 'package:hair_hub/image_picker.dart';

import 'package:hair_hub/shops_available.dart';
// import 'package:sports_star_seeker/firebase_options.dart';
// import 'welcome.dart';
import 'SplashScreen.dart';

// import 'forget_password.dart';
import 'welcome.dart';
import 'barber_signup.dart';
import 'barber_signin.dart';
import 'customer_signup.dart';
import 'set_slots.dart';
import 'booked_slots.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppEntryPoint());
  }
}

class AppEntryPoint extends StatefulWidget {
  @override
  _AppEntryPointState createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  @override
  // void initState() {
  //   super.initState();
  //   // Add a delay to simulate the splash screen
  //   Future.delayed(const Duration(seconds: 3), () {
  //     // Navigate to the main content screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => welcome()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Display the splash screen widget
    return Shops();
  }
}
