import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:sensors/sensors.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:onboardingtest/components/weekdays.dart';
import 'package:onboardingtest/components/durationHours.dart';
import 'dart:async';
import 'dart:io';

class SetupScreen extends StatefulWidget {
  static String id = 'setup_screen';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // Initialize Firebase Service
  FirebaseService _firebaseService = FirebaseService();

  // Initialize Firestore instance
  final _firestore = Firestore.instance;

  // Movement listener stream
  StreamSubscription<AccelerometerEvent> _streamSubscription;

  // Scaffold global key
  GlobalKey<ScaffoldState> _scaffoldKeySetup = GlobalKey<ScaffoldState>();

  int _runDuration = 3;
  double _x, _y, _z;
  double _movementData = 0.0;
  bool _flagMovement = false;
  bool _switchOnOrOff = false;
  String _displayName = '';
  List<int> _selectedWeekdays = [];


  
  // Display username
  Text displayUsername() {
    return _displayName != null
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

  // Retrieve user display name from Firebase
  Future getDisplayName() async {
    String displayName = await _firebaseService.getDisplayName();
    print(displayName);
    setState(() => _displayName = displayName);
  }

  // Logout user from Firebase
  Future logoutUserFromFirebase() async {
    try {
      _firebaseService.logoutUser();
      _firebaseService.logoutNotification(_scaffoldKeySetup);
      await Future.delayed(Duration(milliseconds: 600));
      Navigator.pushNamed(context, LoginScreen.id);
    } catch (e) {
      print(e);
    }
  }

  // Add selected day to days list onPress
  void selectedWeekday(dayActive, dayNumber) {
    print(dayActive);
    if (dayActive == true && !_selectedWeekdays.contains(dayNumber)) {
      _selectedWeekdays.add(dayNumber);
      print(_selectedWeekdays);
    } else if (dayActive == false && _selectedWeekdays.contains(dayNumber)) {
      _selectedWeekdays.remove(dayNumber);
      print(_selectedWeekdays);
    }
  }

  // Toggle between active and inactive day button color
  Color dayButtonActive(day) {
    return day == false ? kPrimaryWhiteOpacity : kPrimaryYellow;
  }

  // Toggle between active and inactive day button color text
  Color dayButtonTextColor(day) {
    return day == false ? kPrimaryYellow : kPrimaryBlackGrey;
  }

  // Listen for device movement
  void movementListener() {
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      _x = event.x;
      _y = event.y;
      _z = event.z;
      setState(() {
        _movementData = (_x * _x + _y * _y);
      });
    });
    if (_movementData >= 2.0) {
      setState(() {
        _flagMovement = true;
      });
    } else {
      setState(() {
        _flagMovement = false;
      });
    }
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
              logoutUserFromFirebase();
            },
          ),
        ],
      ),
    );
  }

  static void test() {
    DateTime time = DateTime.now();
    print('$time #*#*#*#*#*#*#*#*#');
  }

  testTime() {
    TimeOfDay t = startTime;
    final now = DateTime.now();
    DateTime mainTime =
    DateTime(now.year, now.month, now.day, t.hour, t.minute);
    print(mainTime);
    return mainTime;
  }

  @override
  void initState() {
    super.initState();
    getDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    // Maintain port portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Duration of listening to movement
    Duration time = Duration(hours: _runDuration);

    // Log detected movement
    movementLogger(time);

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
                        print(testTime());
                        print('fired!');
                        await AndroidAlarmManager.oneShotAt(testTime(), 0, test,
                            wakeup: true);
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
                                  bodyColor: dayButtonActive(mon),
                                  textColor: dayButtonTextColor(mon),
                                  active: () {
                                    setState(() {
                                      mon == false ? mon = true : mon = false;
                                      selectedWeekday(mon, 1);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Tu',
                                  bodyColor: dayButtonActive(tues),
                                  textColor: dayButtonTextColor(tues),
                                  active: () {
                                    setState(() {
                                      tues == false
                                          ? tues = true
                                          : tues = false;

                                      selectedWeekday(tues, 2);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'W',
                                  bodyColor: dayButtonActive(weds),
                                  textColor: dayButtonTextColor(weds),
                                  active: () {
                                    setState(() {
                                      weds == false
                                          ? weds = true
                                          : weds = false;
                                      selectedWeekday(weds, 3);
                                    });
                                    print(_selectedWeekdays);
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Th',
                                  bodyColor: dayButtonActive(thurs),
                                  textColor: dayButtonTextColor(thurs),
                                  active: () {
                                    setState(() {
                                      thurs == false
                                          ? thurs = true
                                          : thurs = false;
                                      selectedWeekday(thurs, 4);
                                    });
                                    print(_selectedWeekdays);
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'F',
                                  bodyColor: dayButtonActive(fri),
                                  textColor: dayButtonTextColor(fri),
                                  active: () {
                                    setState(() {
                                      fri == false ? fri = true : fri = false;
                                      selectedWeekday(fri, 5);
                                    });
                                    print(_selectedWeekdays);
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
                                  bodyColor: dayButtonActive(sat),
                                  textColor: dayButtonTextColor(sat),
                                  active: () {
                                    setState(() {
                                      print('$sat');
                                      sat == false ? sat = true : sat = false;
                                      selectedWeekday(sat, 6);
                                    });
                                    print(_selectedWeekdays);
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RoundDaysButton(
                                  day: 'Su',
                                  bodyColor: dayButtonActive(sun),
                                  textColor: dayButtonTextColor(sun),
                                  active: () {
                                    setState(() {
                                      print('$sun');
                                      sun == false ? sun = true : sun = false;
                                      selectedWeekday(sun, 7);
                                    });
                                    print(_selectedWeekdays);
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
                            bodyColor: threeHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                threeHrs == false
                                    ? threeHrs = true
                                    : threeHrs = false;
                                if (threeHrs == true) {
                                  setState(() {
                                    _runDuration = 3;
                                  });
                                }
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
                                sixHrs == false ? kPrimaryBlue : kPrimaryWhite,
                            active: () {
                              setState(() {
                                sixHrs == false
                                    ? sixHrs = true
                                    : sixHrs = false;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          HourSelectButton(
                            hour: '12hr',
                            textColor: kPrimaryBlackGrey,
                            bodyColor: twelveHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                twelveHrs == false
                                    ? twelveHrs = true
                                    : twelveHrs = false;
                              });
                              print(twelveHrs);
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          HourSelectButton(
                            hour: '24hr',
                            textColor: kPrimaryBlackGrey,
                            bodyColor: twentyFourHrs == false
                                ? kPrimaryBlue
                                : kPrimaryWhite,
                            active: () {
                              setState(() {
                                twentyFourHrs == false
                                    ? twentyFourHrs = true
                                    : twentyFourHrs = false;
                                print(twentyFourHrs);
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
                        _switchOnOrOff == false
                            ? _switchOnOrOff = true
                            : _switchOnOrOff = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Reset Button');
                      _selectedWeekdays.clear();
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

  void movementLogger(Duration time) {
    if (_switchOnOrOff == true) {
      movementListener();
      if (_flagMovement) {
        _firestore.collection('logs').add({"time": DateTime.now()});
        sleep(Duration(seconds: 6));
      }
      Future.delayed(time, () {
        setState(() {
          _switchOnOrOff = false;
        });
        _streamSubscription.cancel();
      });
    }
  }
}
