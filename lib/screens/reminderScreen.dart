import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'package:intl/intl.dart';
import 'package:virtualfitnesstrainer/widgets/new_reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:virtualfitnesstrainer/models/notificationPlugin.dart';
import 'package:timezone/timezone.dart' as tz;

List<Reminder> reminderlist = [];

class Reminder_list_Screen extends StatefulWidget {
  @override
  _Reminder_list_ScreenState createState() => _Reminder_list_ScreenState();
}

class _Reminder_list_ScreenState extends State<Reminder_list_Screen> {
  SharedPreferences sharedPreferences;
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
    addItem(newReminder);
    setState(() {
      //reminderlist.add(newReminder);
    });
  }

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
    NotifPlug.setListenerForLowerVersions(onNotificationInLowerVersions);
    //.setListenerForLowerVersions(onNotificationInLowerVersions);
    NotifPlug.setOnNotificationClick(onNotificationClick("payload"));
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
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
                    return GestureDetector(
                      onTap: () async {
                        await NotifPlug.showNotification();
                        print('click');

                        //await NotifPlug.showWeeklyAtDayTime();
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                    onSelected: (value) {
                                      if (value == 1)
                                        //edit
                                        ;
                                      else
                                        removeItem(reminderlist[index]);
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
  //       addItem(Todo(title: title));
  //     }
  //   });
  // }

  void addItem(Reminder item) {
    // Insert an item into the top of our list, on index zero
    reminderlist.insert(0, item);
    saveData();
  }

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

  void removeItem(Reminder item) {
    reminderlist.remove(item);
    saveData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      reminderlist = listString
          .map((item) => Reminder.fromMap(json.decode(item)))
          .toList();
      setState(() {});
    }
  }

  void saveData() {
    List<String> stringList =
        reminderlist.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }
}
