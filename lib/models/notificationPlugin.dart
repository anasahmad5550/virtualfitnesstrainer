import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:io' show Platform;

import 'package:rxdart/rxdart.dart';
import 'package:virtualfitnesstrainer/models/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:virtualfitnesstrainer/models/notification.dart';

class notificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var inilizationsetting;

  notificationPlugin() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatformSpecific();
  }

  initializePlatformSpecific() {
    var androidInitializationsetting =
        AndroidInitializationSettings('ic_launcher');
    var iosinitilization = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );

    inilizationsetting = InitializationSettings(
        android: androidInitializationsetting, iOS: iosinitilization);
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(inilizationsetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Title',
      'Test Body', //null
      platformChannelSpecifics,
      payload: 'New Payload',
    );
    print('check');
  }

  // Future<void> _zonedScheduleNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('your channel id',
  //               'your channel name', 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  tz.TZDateTime _nextInstanceOfTenAM(DateTime datetime, location) {
    //final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(location, datetime.year,
        datetime.month, datetime.day, datetime.hour, datetime.minute);
    if (scheduledDate.isBefore(datetime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfSundayAndSaturdayAtSpecificDate(
      DateTime dateTime, location) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM(dateTime, location);
    while (scheduledDate.weekday == DateTime.saturday ||
        scheduledDate.weekday == DateTime.sunday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> showWeeklyAtDayTime(
      DateTime datetime, String title, int id) async {
    final timeZone = TimeZone();
    print(datetime.minute);
    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);

    // tz.TZDateTime scheduledDate = tz.TZDateTime(location, datetime.year,
    //     datetime.month, datetime.day, datetime.hour, datetime.minute);
    //final scheduledDate = tz.TZDateTime.from(datetime, location);

    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        '$title time ${datetime.hour}:${datetime.minute}.${datetime.second}',
        'Reminder ', //null
        _nextInstanceOfSundayAndSaturdayAtSpecificDate(datetime, location),
        //scheduledDate,
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        payload: 'Test Payload',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    print('click 2');
  }
}

notificationPlugin NotifPlug = notificationPlugin();
