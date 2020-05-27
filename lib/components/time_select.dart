import 'package:flutter/material.dart';

TimeOfDay _time = TimeOfDay.now();
TimeOfDay timePicked;
TimeOfDay startTime;

Future<TimeOfDay> selectTime(BuildContext context) async {
  timePicked = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child,
        );
      });

  return timePicked;
}
