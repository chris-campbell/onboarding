import 'package:flutter/material.dart';

class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF048D9B),
      body: Column(
        children: <Widget>[
          Text('Controling the way '),
          Text('fooling'),
          Text('Controling the way '),
          Text('fooling'),
          Text('Controling the way '),
          Text('fooling'),
        ],
      ),
    );
  }
}
