import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'package:intl/intl.dart';

import 'package:virtualfitnesstrainer/widgets/new_reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:virtualfitnesstrainer/models/notificationPlugin.dart';
import 'package:provider/provider.dart';
import 'package:virtualfitnesstrainer/Provider/ReminderList.dart';
import 'package:virtualfitnesstrainer/widgets/alertDialog.dart' as custom;

class Reminder_list_Screen extends StatefulWidget {
  final Function f;

  const Reminder_list_Screen({Key key, this.f}) : super(key: key);
  @override
  _Reminder_list_ScreenState createState() => _Reminder_list_ScreenState();
}

class _Reminder_list_ScreenState extends State<Reminder_list_Screen> {
  SharedPreferences sharedPreferences;

  void allReminderNotification() async {
    final rlist = Provider.of<ReminderList>(context).reminderList;
    for (int i = 0; i < rlist.length; i++) {
      await NotifPlug.showWeeklyAtDayTime(rlist[i].time, rlist[i].title, i);
    }
  }

  void _addNewReminder(String ntitle, DateTime choosentime) {
    final newReminder = Reminder(
        id: DateTime.now().toString(), title: ntitle, time: choosentime);
    // addItem(newReminder);
    Provider.of<ReminderList>(context, listen: false).addItem(newReminder);
    //saveData();
    widget.f();
  }

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

  @override
  void initState() {
    super.initState();
    NotifPlug.setListenerForLowerVersions(onNotificationInLowerVersions);

    NotifPlug.setOnNotificationClick(onNotificationClick("payload"));
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }

  @override
  Widget build(BuildContext context) {
    final reminderlist = Provider.of<ReminderList>(context).reminderList;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    allReminderNotification();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewReminder(context),
        child: Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Reminder',
              style: TextStyle(
                  fontSize: width * 0.08, fontWeight: FontWeight.bold),
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
                      return GestureDetector(
                        onTap: () async {
                          //await NotifPlug.showNotification();
                          print('click');

                          // await NotifPlug.showWeeklyAtDayTime(
                          //     reminderlist[index].time,
                          //     reminderlist[index].title);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          //height: MediaQuery.of(context).size.height * 0.11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          DateFormat('hh:mm a ')
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
                                      onSelected: (value) {
                                        if (value == 1) {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => custom.Dialog(
                                                    previousReminder:
                                                        reminderlist[index],
                                                  ));
                                          widget.f();
                                        } else {
                                          Provider.of<ReminderList>(context,
                                                  listen: false)
                                              .removeItem(reminderlist[index]);
                                          //saveData();
                                          widget.f();
                                        }
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.more_vert),
                                      itemBuilder: (_) => [
                                            PopupMenuItem(
                                              child: Text('Edit'),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Text('Delete'),
                                              value: 0,
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
                        ),
                      );
                    },
                    itemCount: reminderlist.length),
              ),
            )
          ],
        ),
      ),
    );
  }
  // void goToNewItemView(){
  //   // Here we are pushing the new view into the Navigator stack. By using a
  //   // MaterialPageRoute we get standard behaviour of a Material app, which will
  //   // show a back button automatically for each platform on the left top corner
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //     return NewTodoView();
  //   })).then((title){
  //     if(title != null) {
  //       addItem((title: title));
  //     }
  //   });
  // }

  // void changeItemCompleteness(Reminder item){
  //   setState(() {
  //     item.completed = !item.completed;
  //   });
  //   saveData();
  // }

  // void goToEditItemView(item){
  //   // We re-use the NewTodoView and push it to the Navigator stack just like
  //   // before, but now we send the title of the item on the class constructor
  //   // and expect a new title to be returned so that we can edit the item
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
  //     return NewTodoView(item: item);
  //   })).then((title){
  //     if(title != null) {
  //       editItem(item, title);
  //     }
  //   });
  // }

  // void editItem(Reminder item ,String title){
  //   item.title = title;
  //   saveData();
  // }

}
