import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtualfitnesstrainer/Provider/ReminderList.dart';
import 'package:virtualfitnesstrainer/models/reminder.dart';
import 'package:provider/provider.dart';

class Dialog extends StatefulWidget {
  final Reminder previousReminder;

  const Dialog({
    Key key,
    this.previousReminder,
  }) : super(key: key);
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  DateTime val;
  DateTime _selectedtime;
  TextEditingController _controller = TextEditingController();
  String titleVal;

  void _selecttime(DateTime dt) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dt),
    ).then((value) {
      if (value == null)
        return;
      else {
        //final now = new DateTime.now();
        print('hello');
        val = DateTime(dt.year, dt.month, dt.day, value.hour, value.minute);
      }

      setState(() {
        _selectedtime = val;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rlist = Provider.of<ReminderList>(context);
    _controller = TextEditingController(
        text: titleVal == null ? widget.previousReminder.title : titleVal);
    return AlertDialog(
      scrollable: true,
      title: Text('Edit Reminder'),
      content: Column(
        children: [
          TextField(
            controller: _controller,
            onChanged: (value) {
              titleVal = value;
            },
            decoration: InputDecoration(
              labelText: 'title',
              hintText: 'title of Reminder',
            ),
          ),
          Container(
            //height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'selected time: ${DateFormat('hh:mm a ').format(_selectedtime == null ? widget.previousReminder.time : _selectedtime)}',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _selecttime(widget.previousReminder.time);
                    },
                    child: Text('select time'))
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: Text('cancel')),
        ElevatedButton(
            onPressed: () {
              if (_controller.text == '' || _controller.text == ' ') return;
              final Reminder newR = Reminder(
                  id: widget.previousReminder.id,
                  title: _controller.text,
                  time: _selectedtime);
              rlist.editchanges(widget.previousReminder.id, newR);
              Navigator.of(context).pop();
            },
            child: Text('save')),
      ],
    );
  }
}
