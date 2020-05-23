import 'package:flutter/material.dart';
import 'package:onboardingtest/constants.dart';

class ControlTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final TextInputType textType;
  const ControlTextField({this.hintText, this.icon, this.textType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Color(0xFF333333),
        child: TextFormField(
          keyboardType: textType,
          style: TextStyle(
            color: Color(0xFFEBEBEB),
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: kFocusBorderStyle,
            enabledBorder: kEnabledBorderStyle,
            filled: true,
            fillColor: Color(0xFF333333),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 21.0,
              color: Color(0xFF999999),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: icon,
            ),
          ),
          validator: (value) {
            return value;
          },
        ),
      ),
    );
  }
}
