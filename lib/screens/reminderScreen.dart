import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'package:intl/intl.dart';
import 'package:virtualfitnesstrainer/widgets/new_reminder.dart';

class Reminder_list_Screen extends StatefulWidget {
  @override
  _Reminder_list_ScreenState createState() => _Reminder_list_ScreenState();
}

class _Reminder_list_ScreenState extends State<Reminder_list_Screen> {
  List<Reminder> reminderlist = [
    Reminder(id: '1st', title: 'workout', time: DateTime.now()),
    Reminder(
      id: '2nd',
      title: 'meal 1',
      time: DateTime.now(),
    ),
  ];
  void _startAddNewReminder(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewReminder(_addNewReminder));
      },
    );
  }

  void _addNewReminder(String ntitle, DateTime choosentime) {
    final newReminder = Reminder(
        id: DateTime.now().toString(), title: ntitle, time: choosentime);

    setState(() {
      reminderlist.add(newReminder);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewReminder(context),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            'Reminder',
            style:
                TextStyle(fontSize: width * 0.08, fontWeight: FontWeight.bold),
          )),
          Container(
            child: Text(
              'Today Upcomings',
              style: TextStyle(fontSize: width * 0.07),
            ),
            //padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          SingleChildScrollView(
            child: Container(
              height: height * 0.7,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat('kk:mm a ')
                                          .format(reminderlist[index].time),
                                      style: TextStyle(
                                          fontSize: width * 0.07,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.notifications_active,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton(
                                  onSelected: (_) {},
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (_) => [
                                        PopupMenuItem(
                                          child: Text('Edit'),
                                          //value: filteroptions.favourite,
                                        ),
                                        PopupMenuItem(
                                          child: Text('Delete'),
                                          //value: filteroptions.all,
                                        )
                                      ]),
                            ],
                          ),
                          Text(
                            '${reminderlist[index].title}',
                            style: TextStyle(fontSize: width * 0.05),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: reminderlist.length),
            ),
          )
        ],
      ),
    );
  }
}
