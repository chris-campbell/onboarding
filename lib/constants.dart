import 'package:flutter/material.dart';

// Primary application colors
Color kPrimaryYellow = Color(0xFFF0F456);
Color kPrimaryBlue = Color(0xFF048D9B);
Color kPrimaryBlackGrey = Color(0xFF333333);
Color kPrimaryWhite = Colors.white;
Color kPrimaryWhiteOpacity = kPrimaryWhite.withOpacity(0.0);
Color kPrimaryLightGrey = Colors.grey;
Color kPrimaryTextGrey = Color(0xFF999999);

final kTitleStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0XFF333333),
  fontWeight: FontWeight.bold,
);

final kSubtitleStyle = TextStyle(
  fontSize: 17.0,
  color: Color(0XFF333333),
);

const kFocusBorderStyle = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.white,
    width: 2,
  ),
);

const kEnabledBorderStyle = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xFF999999),
    width: 2,
  ),
);

const kSetupScreenVerticalText = TextStyle(
  fontSize: 14.0,
  color: Color(0xFF808e9b),
  letterSpacing: 2.0,
);
