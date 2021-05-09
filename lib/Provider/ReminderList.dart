import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderList with ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminderList {
    return [..._reminders];
  }

  set Setreminder(List<Reminder> r) {
    this._reminders = r;
  }

  void addReminder() {}

  void addItem(Reminder item) {
    // Insert an item into the top of our list, on index zero
    _reminders.insert(0, item);
    notifyListeners();
    //saveData();
  }

  void removeItem(Reminder item) {
    _reminders.remove(item);
    notifyListeners();
    //saveData();
  }

  void editchanges(String id, Reminder editedReminder) {
    int index = _reminders.indexWhere((element) => element.id == id);
    _reminders[index] = editedReminder;
    notifyListeners();
  }

  Reminder comingReminder() {
    Reminder UpcomingReminder = Reminder(
        id: DateTime.now().toString(),
        time: DateTime.now(),
        title: 'No Reminder');
    if (reminderList.length != 0) {
      UpcomingReminder = _reminders.reduce((a, b) =>
          a.time.difference(DateTime.now()).abs() <
                  b.time.difference(DateTime.now()).abs()
              ? a
              : b);
    }

    return UpcomingReminder;
  }
}
