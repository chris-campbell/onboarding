import 'package:flutter/material.dart';
import 'package:onboardingtest/constants.dart';


bool mon = false, tues = false, weds = false, thurs = false,
     fri = false, sat = false, sun = false;

List<int> selectedDays = [];

  // Add selected day to days list onPress
  void selectedWeekday(dayActive, dayNumber) {
    print(dayActive);
    if (dayActive == true && !selectedDays.contains(dayNumber)) {
      selectedDays.add(dayNumber);
      print(selectedDays);
    } else if (dayActive == false && selectedDays.contains(dayNumber)) {
      selectedDays.remove(dayNumber);
      print(selectedDays);
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