import 'package:flutter/material.dart';
import 'package:onboardingtest/screens/setup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

Future main() async {
  runApp(new MyApp());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        SetupScreen.id: (context) => SetupScreen(),
      },
    );
  }
}

