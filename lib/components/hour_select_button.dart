import 'package:flutter/material.dart';

class HourSelectButton extends StatelessWidget {
  final String hour;
  final Function active;
  final Color bodyColor;
  final Color textColor;

  HourSelectButton({this.hour, this.active, this.bodyColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 60.0,
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: bodyColor,
        child: Text(
          hour,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
          ),
        ),
        onPressed: active,
      ),
    );
  }
}