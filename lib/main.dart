import 'dart:math';
import 'package:flutter/material.dart';
import 'package:onboardingtest/screens/setup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'dart:isolate';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AndroidAlarmManager.initialize();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SetupScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        SetupScreen.id: (context) => SetupScreen(),
      },
    );
  }
}