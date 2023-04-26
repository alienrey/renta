import 'dart:async';

import 'package:flutter/material.dart';
import 'package:renta/screens/sign_in_screen.dart';
import 'package:renta/screens/walk_through_screen.dart';
import 'package:renta/utils/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          // MaterialPageRoute(builder: (context) => WalkThroughScreen()),
          MaterialPageRoute(builder: (context) => SignInScreen()),

          (route) => false,
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(splash_logo, width: 200, height: 200, fit: BoxFit.cover),
      ),
    );
  }
}
