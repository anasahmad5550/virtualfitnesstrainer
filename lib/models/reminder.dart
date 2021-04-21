class Reminder {
  final String id;
  final String title;
  final DateTime time;

  Reminder({this.id, this.title, this.time});

  Reminder.fromMap(Map map)
      : this.id = map['id'],
        this.title = map['title'],
        this.time = DateTime.parse(map['time']);

  Map toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'time': this.time.toIso8601String()
    };
  }
}

// List<Reminder> reminderlist = [
//   Reminder(id: '1st', title: 'workout', time: DateTime.now()),
//   Reminder(
//     id: '2nd',
//     title: 'meal 1',
//     time: DateTime.now(),
//   ),
// ];
