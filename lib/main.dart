import 'package:flutter/material.dart';
import 'package:tugasmod3_kel17/screens/home.dart';
import 'package:tugasmod3_kel17/screens/detail.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'screen/home.dart';

void main() async {
  runApp(AnimeApp());
}

const primaryColor = Color(0xFF151026);

class AnimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Anime app',
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        home: AnimatedSplashScreen(
            duration: 3000,
            splash:
                '[n]https://cdn1.iconfinder.com/data/icons/logos-brands-in-colors/231/among-us-player-red-512.png',
            nextScreen: Home(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white));
  }
}
