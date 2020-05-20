import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF333333),
            Color(0xFF0d0d0d),
          ]
        ),
      ),
      child: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
