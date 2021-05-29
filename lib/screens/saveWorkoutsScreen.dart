import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/exercise.dart';
import 'exerciseScreen.dart';

class SaveWorkoutsScreen extends StatefulWidget {
  @override
  _SaveWorkoutsScreenState createState() => _SaveWorkoutsScreenState();

  Exercise exercise = null;
  SaveWorkoutsScreen({Key key, this.exercise}) : super(key: key);
}

class _SaveWorkoutsScreenState extends State<SaveWorkoutsScreen> {
  final List<String> names = <String>[
    'Chest',
    'Bcak',
  ];
  final List<List<Exercise>> exe = <List<Exercise>>[
    <Exercise>[],
    <Exercise>[],
  ];
  void addItemToList(String wkout) {
    setState(() {
      names.insert(0, wkout);
    });
  }

  Widget showbottomheet() {
    var list;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 200,
              child: Column(
                children: [
                  TextField(
                    controller: workouts,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter workout name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Text('Cancel'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            workout = workouts.text;
                            workouts.clear();
                            // print(workout);
                            addItemToList(workout);
                            exe.add(<Exercise>[]);
                            Navigator.pop(context);
                          },
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
    return list;
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        setState(() {
          names.remove(names[index]);
        });
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  var workout;
  final workouts = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1D0E36),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showbottomheet();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: Column(children: [
          Expanded(
            flex: 0,
            child: Text('Saved Workouts',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.0,
                  fontWeight: FontWeight.w900,
                )),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Container(
                          height: 50,
                          margin: EdgeInsets.all(2),
                          color: Colors.blue[400],
                          child: Center(
                              child: Text(
                            '${names[index]} ',
                            style: TextStyle(fontSize: 18),
                          )),
                        ),
                        onLongPress: () {
                          showAlertDialog(context, index);
                        },
                        onTap: () {
                          if (widget.exercise != null) {
                            exe[index].add(widget.exercise);

                            print(exe[index][0].title);
                            widget.exercise = null;
                            Navigator.pop(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExerciseScreen(
                                    muscleCategory: names[index],
                                    musclename: exe[index],
                                  ),
                                ));
                          }

                          print(Text('${names[index]} '));
                        },
                      );
                    }),
              ))
        ]),
      ),
    );
  }
}
