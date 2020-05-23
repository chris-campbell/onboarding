import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:onboardingtest/constants.dart';
import 'logs_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: Padding(
        padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 70),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/images/Group 90.png'),
                      width: 130.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Log()));
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        FontAwesomeIcons.briefcase,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF048D9B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: SwitchListTile(
                        activeColor: Color(0xFFF0F456),
                        inactiveThumbColor: Color(0XFF999999),
                        inactiveTrackColor: Color(0xFF333333),
                        activeTrackColor: Color(0xFF333333),
                        title: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Activate recurrence',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        value: true,
                        onChanged: (newValue) {},
                        secondary: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Select Days',
                      style: kSetupScreenVerticalText,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundDaysButton(
                                day: 'M',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundDaysButton(
                                day: 'Tu',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundDaysButton(
                                day: 'W',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundDaysButton(
                                day: 'Th',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundDaysButton(
                                day: 'F',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundDaysButton(
                                day: 'Sa',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundDaysButton(
                                day: 'Su',
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Select hours',
                      style: kSetupScreenVerticalText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        HourSelectButton(
                          hour: '3hr',
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        HourSelectButton(
                          hour: '6hr',
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        HourSelectButton(
                          hour: '12hr',
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        HourSelectButton(
                          hour: '24hr',
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: 30.0,),
              Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'Start time',
                      style: kSetupScreenVerticalText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text('9:47PM', style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
          SizedBox(height: 30.0,),
          ButtonTheme(
            minWidth: double.infinity,
            height: 70.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              color: Color(0xFF048D9B),
              child: Text(
                'Start',
                style: TextStyle(
                    color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {},
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}

class HourSelectButton extends StatelessWidget {
  final String hour;

  HourSelectButton({this.hour});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 60.0,
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Color(0xFF048D9B),
        child: Text(
          hour,
          style: TextStyle(
              color: Colors.white,
            fontSize: 15,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class RoundDaysButton extends StatelessWidget {
  final String day;

  RoundDaysButton({this.day});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Hello, its me.'),
      child: Container(
        width: 47.0,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF0F456),
            width: 2.0,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
