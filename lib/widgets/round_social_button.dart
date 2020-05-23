import 'package:flutter/material.dart';

class RoundSocialButton extends StatelessWidget {
  final Icon icon;
  final Function action;

  RoundSocialButton({this.icon, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 60.0,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
