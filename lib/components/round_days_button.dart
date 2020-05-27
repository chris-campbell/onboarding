import 'package:flutter/material.dart';
import 'package:onboardingtest/constants.dart';

class RoundDaysButton extends StatelessWidget {
  final String day;
  final Function active;
  final Color bodyColor;
  final Color borderColor;
  final Color textColor;

  RoundDaysButton(
      {this.day,
        this.active,
        this.bodyColor,
        this.borderColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: active,
      child: Container(
        width: 47.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: bodyColor,
          border: Border.all(
            width: 2.0,
            color: kPrimaryYellow,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
