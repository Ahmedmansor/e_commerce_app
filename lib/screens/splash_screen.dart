import 'package:e_commerce_app/repos/const.dart';
import 'package:flutter/material.dart';

import '../utils/navigation_util.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      NavigationUtils.goToAndOff(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Developed by ',
                  style: ThemeText.boardingScreenBodysmall,
                  children: [
                    TextSpan(
                      text: 'Ahmed Mansour',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue[900]),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
