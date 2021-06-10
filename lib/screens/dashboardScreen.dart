import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:virtualfitnesstrainer/Provider/ReminderList.dart';

import 'package:virtualfitnesstrainer/widgets/homeContainers.dart';
import 'bmiCalculatorScreen.dart';
import 'MuscleGroup.dart';
import 'reminderScreen.dart';

import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferences sharedPreferences;
  bool indicator = false;

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    indicator = false;
    loadData();
    setState(() {});
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      Provider.of<ReminderList>(context, listen: false).Setreminder = listString
          .map((item) => Reminder.fromMap(json.decode(item)))
          .toList();
      print('..2');
    }
  }

  @override
  void initState() {
    indicator = true;
    loadSharedPreferencesAndData();

    super.initState();
  }

  void saveData() {
    List<String> stringList = Provider.of<ReminderList>(context, listen: false)
        .reminderList
        .map((item) => json.encode(item.toMap()))
        .toList();
    sharedPreferences.setStringList('list', stringList);
  }

  void pushMuscleGroup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return ExerciseMuscleGroupScreen();
    }));
  }

  void pushDietPlan(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return DietPlanscreen();
    }));
  }

  void pushbmi(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BmiCalculaorScreen();
    }));
    // Navigator.of(context).pushNamed(BmiCalculaorScreen.routeid);
  }

  void pushreminder(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Reminder_list_Screen(
        f: saveData,
      );
    }));
    // Navigator.of(context).pushNamed(BmiCalculaorScreen.routeid);
  }

  @override
  Widget build(BuildContext context) {
    final upComingReminder = Provider.of<ReminderList>(context, listen: false);
    final medaiQ = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: indicator
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SafeArea(
                  child: Container(
                    height: (medaiQ.size.height - medaiQ.padding.top) * 0.31,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'images/home.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          colorBlendMode: BlendMode.colorBurn,
                        ),
                        Container(
                          height:
                              (medaiQ.size.height - medaiQ.padding.top) * 0.25,
                          width: medaiQ.size.width * 0.7,
                          decoration: new BoxDecoration(
                            color: Colors.white30,
                            border: Border.all(color: Colors.black, width: 0.0),
                            borderRadius: new BorderRadius.all(
                                Radius.elliptical(200, 150)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<ReminderList>(
                                builder: (ctx, Reminder, child) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${upComingReminder.comingReminder().title} ',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    if (upComingReminder.reminderList.length >
                                        0)
                                      Text(
                                        DateFormat('hh:mm a ').format(
                                            upComingReminder
                                                .comingReminder()
                                                .time),
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.pink),
                                      ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Upcoming Reminder',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      border: Border.all(color: Theme.of(context).canvasColor),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              (medaiQ.size.height - medaiQ.padding.top) * 0.015,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeContainer(
                                onpress: () => pushMuscleGroup(context),
                                title: 'Exercises',
                                icnimgurl: 'images/icn1.png',
                                imgurl: 'images/image1.png',
                              ),
                              HomeContainer(
                                onpress: () => pushreminder(context),
                                title: 'Reminder',
                                icnimgurl: 'images/icn4.png',
                                imgurl: 'images/image2.png',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeContainer(
                                onpress: () => pushDietPlan(context),
                                title: 'Diet Plan',
                                icnimgurl: 'images/icn2.png',
                                imgurl: 'images/image3.png',
                              ),
                              HomeContainer(
                                onpress: () => pushbmi(context),
                                title: 'Bmi',
                                icnimgurl: 'images/icn3.png',
                                imgurl: 'images/image4.png',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              (medaiQ.size.height - medaiQ.padding.top) * 0.015,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
