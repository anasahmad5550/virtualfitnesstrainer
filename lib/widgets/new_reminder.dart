import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptie_flat_button.dart';

class NewReminder extends StatefulWidget {
  final Function addR;
  NewReminder(this.addR);
  @override
  _NewReminderState createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  final titleController = TextEditingController();
  DateTime _selecteddate;
  DateTime val;

  void _selectdate() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    ).then((value) {
      if (value == null)
        return;
      else {
        final now = new DateTime.now();
        val = DateTime(now.year, now.month, now.day, value.hour, value.minute);
      }
      //   showDatePicker(
      //               context: context,
      //               initialDate: DateTime.now(),
      //               firstDate: DateTime(2019),
      //               lastDate: DateTime.now())
      //           .then((value) {
      //         if (value == null) return;

      setState(() {
        _selecteddate = val;
      });
    });
  }

  void submitData() {
    final titlecont = titleController.text;

    if (titlecont == '' || _selecteddate == null) {
      return;
    }

    widget.addR(titlecont, _selecteddate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selecteddate == null
                            ? 'No time choosen '
                            : 'selected time: ${DateFormat('kk:mm a ').format(_selecteddate)}',
                      ),
                    ),
                    Adaptiveflatbutton(
                      text: 'choose date',
                      handler: _selectdate,
                    )
                  ],
                ),
              ),
              RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: submitData,
                  child: Text(
                    'Add Reminder',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
