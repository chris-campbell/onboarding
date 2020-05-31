import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboardingtest/constants.dart';
import 'package:onboardingtest/screens/login_screen.dart';
import 'package:flutter/services.dart';
import '../components/firebase_services.dart';
import '../components/time_select.dart';
import '../components/hour_select_button.dart';
import '../components/round_days_button.dart';
import '../components/on_back_press.dart';
import 'package:sensors/sensors.dart';

import 'dart:async';

class SetupScreen extends StatefulWidget {
  static String id = 'setup_screen';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  FirebaseService _firebaseService = FirebaseService();
  double x, y, z;
  bool _mon, _tues, _weds, _thurs, _fri, _sat, _sun = false;
  bool _threeHrs, _sixHrs, _twelveHrs, _twentyFourHrs = false;
  bool switchOnOrOff = false;
  List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  String _displayName = '';

  // Scaffold global key
  GlobalKey<ScaffoldState> _scaffoldKeySetup = GlobalKey<ScaffoldState>();

  // Retrieve user display name from Firebase
  Future getDisplayName() async {
    String displayName = await _firebaseService.getDisplayName();
    setState(() => _displayName = displayName);
  }

  // Logout user from Firebase
  Future _logoutUser() async {
    try {
      await _firebaseService.signout();
      _scaffoldKeySetup.currentState.showSnackBar(SnackBar(
        content: Text('You have successfully signed out'),
      ));

      await Future.delayed(Duration(milliseconds: 500));

      Navigator.pushNamed(context, LoginScreen.id);
    } catch (e) {
      print(e);
    }
  }

  // Displays users name
  displayUsername() {
    _displayName != null
        ? Text(
            'Logged in, $_displayName',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: kPrimaryLightGrey,
              fontSize: 15.0,
            ),
          )
        : Text('no name');
  }

  Color dayButtonActive(day) {
    return day == false ? kPrimaryWhiteOpacity : kPrimaryYellow;
  }

  Color dayButtonTextColor(day) {
    return day == false ? kPrimaryYellow : kPrimaryBlackGrey;
  }

  test() {
//    TimeOfDay now = TimeOfDay.now();
    TimeOfDay releaseTime = TimeOfDay(hour: 15, minute: 0);
    return releaseTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    getDisplayName();
    super.initState();
  }

  // Prevent user from going back to login screen
  Future<bool> _onBackPressed() {
    return showDialog(
      context: (context),
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit dontTouch?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              _logoutUser();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Duration time = Duration(seconds: 3);

    // if component toggled on, delay for given duration
    // then switch toggle to off
    if (switchOnOrOff == true) {
      _streamSubscription
          .add(accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {x = event.x; y = event.y; z = event.z; });
        print(
            '${x.toStringAsFixed(1)} ${y.toStringAsFixed(1)} ${z.toStringAsFixed(1)}');
      }));

      print('Listening.....');
      Future.delayed(time, () {
        setState(() {
          switchOnOrOff = false;
        });
        for (StreamSubscription<dynamic> subscription in _streamSubscription) {
            subscription.cancel();
            print(subscription);
        }
      });
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKeySetup,
        backgroundColor: kPrimaryBlackGrey,
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
                      onTap: () async {
                        Duration time = Duration(seconds: 10);

                        if (switchOnOrOff == true) {
                          print('Listening');
                        } else {
                          await Future.delayed(time, () {
                            setState(() {
                              switchOnOrOff = true;
                            });

                            print(switchOnOrOff);
                          });
                        }

                        print(switchOnOrOff);

//                        Navigator.pushNamed(context, LoginScreen.id);
//                      var _timer = Timer(Duration(seconds: 5), () {
//                        print('hello');
//                      });
//                        var delay = await Future.delayed(Duration(seconds: 10,));
//                        TimeOfDay releaseTime = TimeOfDay(hour: 0, minute: 1 + delay);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          FontAwesomeIcons.briefcase,
                          color: kPrimaryWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  child: displayUsername(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: kPrimaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: SwitchListTile(
                          activeColor: kPrimaryYellow,
                          inactiveThumbColor: Color(0XFF999999),
                          inactiveTrackColor: kPrimaryBlackGrey,
                          activeTrackColor: kPrimaryBlackGrey,
                          title: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Activate recurrence',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kPrimaryBlackGrey,
                              ),
                            ),
                          ),
                          value: true,
                          onChanged: (newValue) {},
                          secondary: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Icon(
                              FontAwesomeIcons.rocket,
                              color: kPrimaryBlackGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 38.0),
                        child: Text(
                          'Select days',
                          style: kSetupScreenVerticalText,
                        ),
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
                                  bodyColor: dayButtonActive(_mon),
                                  textColor: dayButtonTextColor(_mon),
                                  active: () {
                                    setState(() {
                                      _mon == false
                                          ? _mon = true
                                          : _mon = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Tu',
                                  bodyColor: dayButtonActive(_tues),
                                  textColor: dayButtonTextColor(_tues),
                                  active: () {
                                    setState(() {
                                      _tues == false
                                          ? _tues = true
                                          : _tues = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'W',
                                  bodyColor: dayButtonActive(_weds),
                                  textColor: dayButtonTextColor(_weds),
                                  active: () {
                                    setState(() {
                                      _weds == false
                                          ? _weds = true
                                          : _weds = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Th',
                                  bodyColor: dayButtonActive(_thurs),
                                  textColor: dayButtonTextColor(_thurs),
                                  active: () {
                                    setState(() {
                                      _thurs == false
                                          ? _thurs = true
                                          : _thurs = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'F',
                                  bodyColor: dayButtonActive(_fri),
                                  textColor: dayButtonTextColor(_fri),
                                  active: () {
                                    setState(() {
                                      _fri == false
                                          ? _fri = true
                                          : _fri = false;
                                    });
                                  },
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
                                  bodyColor: dayButtonActive(_sat),
                                  textColor: dayButtonTextColor(_sat),
                                  active: () {
                                    setState(() {
                                      _sat == false
                                          ? _sat = true
                                          : _sat = false;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Su',
                                  bodyColor: dayButtonActive(_sun),
                                  textColor: dayButtonTextColor(_sun),
                                  active: () {
                                    setState(() {
                                      return _sun == false
                                          ? _sun = true
                                          : _sun = false;
                                    });
                                  },
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
                  height: 20.0,
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
                            textColor: kPrimaryBlackGrey,
                            bodyColor: _threeHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                _threeHrs == false
                                    ? _threeHrs = true
                                    : _threeHrs = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          HourSelectButton(
                            hour: '6hr',
                            textColor: kPrimaryBlackGrey,
                            bodyColor:
                                _sixHrs == false ? kPrimaryBlue : kPrimaryWhite,
                            active: () {
                              setState(() {
                                _sixHrs == false
                                    ? _sixHrs = true
                                    : _sixHrs = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          HourSelectButton(
                            hour: '12hr',
                            textColor: kPrimaryBlackGrey,
                            bodyColor: _twelveHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                _twelveHrs == false
                                    ? _twelveHrs = true
                                    : _twelveHrs = false;
                              });
                              print(_twelveHrs);
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          HourSelectButton(
                            hour: '24hr',
                            textColor: kPrimaryBlackGrey,
                            bodyColor: _twentyFourHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                _twentyFourHrs == false
                                    ? _twentyFourHrs = true
                                    : _twentyFourHrs = false;
                                print(_twentyFourHrs);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        'Start time',
                        style: kSetupScreenVerticalText,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () async {
                            var time = await selectTime(context);
                            if (time != null) {
                              setState(() {
                                startTime = time;
                                print(startTime);
                              });
                            }
                          },
                          child: Text(
                            '${startTime != null ? startTime.format(context) : "12:00 AM"}',
                            style: TextStyle(
                              color: kPrimaryWhite,
                              fontSize: 67.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 70.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    color: kPrimaryBlue,
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: kPrimaryBlackGrey,
                        fontSize: 17.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        switchOnOrOff == false
                            ? switchOnOrOff = true
                            : switchOnOrOff = false;
                      });

                      print(switchOnOrOff);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Reset Button');
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: kPrimaryYellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
