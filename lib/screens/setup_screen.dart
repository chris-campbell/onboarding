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
import 'package:onboardingtest/components/weekdays.dart';
import 'package:onboardingtest/components/durationHours.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:onboardingtest/components/alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:onboardingtest/components/log_reader.dart';
import 'package:onboardingtest/components/log.dart';
import 'package:path_provider/path_provider.dart';

class SetupScreen extends StatefulWidget {
  static String id = 'setup_screen';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static const platform = const MethodChannel('com.example.onboarding');

  // Initialize Firebase Service
  FirebaseService _firebaseService = FirebaseService();

  // Initialize Firestore instance
  final _firestore = Firestore.instance;

  // Movement listener stream
  StreamSubscription<UserAccelerometerEvent> _streamSubscription;

  // Scaffold global key
  GlobalKey<ScaffoldState> _scaffoldKeySetup = GlobalKey<ScaffoldState>();

  Log log = new Log();

  List<double> movementList = new List();

  int alarmId = 0;
  int _runDuration = 3;
  double _x, _y, _z;
  String _displayName = '';

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

  double getAverage(list) {
    var total = 0.0;
    for (var num in list) {
      total += num;
    }
    return total / list.length;
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

  // Listen for device movement
  void movementListener() {
    double movementData;

    _streamSubscription = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      _x = event.x;
      _y = event.y;
      _z = event.z;

      movementData = (_x * _x + _y * _y + _z * _z);
      if (movementData >= 10) {
        movementList.add(movementData);
      } else if (movementData < 1.0){
        if (movementList.isNotEmpty) {

          var content = {
            'average_movement_data': movementData,
            'timestamp': DateTime.now()
          };

          log.writeLogsToFile(content);
          print(getAverage(movementList));
          movementList.clear();
        }
      }
      print(movementData);
    });
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
              _sendToForeground();
             SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }

  Future<bool> initSettings() async {
    bool init = await AlarmManager.init(
      exact: true,
      alarmClock: true,
      wakeup: true,
    );
    return init;
  }

  @override
  void initState() {
    super.initState();
    initSettings();
  }

  // Format TimeOfDay with DateTime for alarm manager
  DateTime userGivenStartTime() {
    TimeOfDay t = startTime;
    final n = DateTime.now();
    DateTime mainTime = DateTime(n.year, n.month, n.day, t.hour, t.minute);
    return mainTime;
  }

  Future<void> _sendToForeground() async {
    try {
      await platform.invokeMethod('sendtoforeground');
    } on PlatformException catch (e) {
      print('Failed to send application to foreground.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Maintain port portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// Duration of listening to movement
    Duration time = Duration(hours: _runDuration);

    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
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
                      onTap: () {
//                          log.writer("hello");
//                          _sendToForeground();
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
                                    print(selectedDays);
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
                                    print(selectedDays);
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
                                    print(selectedDays);
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
                                    print(selectedDays);
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
                                    print(selectedDays);
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
                    onPressed: () async {
                      await AlarmManager.oneShotAt(
                          userGivenStartTime(),
                          Random().nextInt(pow(2, 31)),
                          (int id) => movementListener(),
                          wakeup: true);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Reset Button');
//                      selectedDays.clear();

//                    _streamSubscription.resume();
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