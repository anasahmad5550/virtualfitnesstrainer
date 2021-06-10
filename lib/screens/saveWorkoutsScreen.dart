import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/exercise.dart';
import 'exerciseScreen.dart';
import 'package:virtualfitnesstrainer/helpers/saveWorkouts.dart';
import 'package:provider/provider.dart';

class SaveWorkoutsScreen extends StatefulWidget {
  @override
  _SaveWorkoutsScreenState createState() => _SaveWorkoutsScreenState();

  Exercise exercise = null;
  SaveWorkoutsScreen({Key key, this.exercise}) : super(key: key);
}

class _SaveWorkoutsScreenState extends State<SaveWorkoutsScreen> {
  // final List<String> names = <String>[
  //   'Chest',
  //   'Bcak',
  // ];
  // final List<List<Exercise>> exe = <List<Exercise>>[
  //   <Exercise>[],
  //   <Exercise>[],
  // ];
  // void addItemToList(String wkout) {
  //   names.insert(0, wkout);
  // }

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
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text('Cancel'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            print(workouts.text);
                            workout = workouts.text;
                            workouts.clear();
                            Provider.of<Saveworkouts>(context, listen: false)
                                .addItemToList(workout);
                            Navigator.pop(context);
                          },
                          color: Theme.of(context).accentColor,
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

  showAlertDialog(BuildContext ctx, int index, savelist) {
    // show the dialog
    showDialog(
        context: ctx,
        builder: (BuildContext cont) => AlertDialog(
              title: Text("Delete"),
              content: Text("Are you sure you want to delete?"),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(cont).pop();
                  },
                ),
                FlatButton(
                  child: Text("Delete"),
                  onPressed: () async {
                    await savelist
                        .removelistfromDB(savelist.saveWorkoutList[index]);
                    Navigator.of(cont).pop();
                  },
                ),
              ],
            ));
  }

  String workout;
  final workouts = TextEditingController();
  bool isLoading = false;

  void AddExerciseinSaveWorkout(int index, Saveworkouts savelist) async {
    final exercisedata = Provider.of<Saveworkouts>(context, listen: false);

    if (widget.exercise != null) {
      exercisedata.addExerciseToList(
          savelist.saveWorkoutList[index], widget.exercise);
      widget.exercise = null;
      Navigator.pop(context);
    } else {
      setState(() {
        isLoading = true;
      });
      await exercisedata.fetchExercisesInList(savelist.saveWorkoutList[index]);
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseScreen(
              muscleCategory: savelist.saveWorkoutList[index],
              musclename: exercisedata.exerciseslist,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Save Workouts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottomheet();
        },
        child: Icon(Icons.add),
        //backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: Provider.of<Saveworkouts>(context, listen: false).fetchList(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Saveworkouts>(
                child: Center(
                  child: const Text('No List Added yet, start adding some!'),
                ),
                builder: (ctx, savelist, ch) =>
                    savelist.saveWorkoutList.length <= 0
                        ? ch
                        : Column(children: [
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount:
                                              savelist.saveWorkoutList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                                title: Container(
                                                  height: 50,
                                                  margin: EdgeInsets.all(2),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Center(
                                                      child: Text(
                                                    '${savelist.saveWorkoutList[index]} ',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  )),
                                                ),
                                                onLongPress: () {
                                                  showAlertDialog(
                                                      context, index, savelist);
                                                },
                                                onTap: () {
                                                  AddExerciseinSaveWorkout(
                                                      index, savelist);
                                                });
                                          }),
                                    ))
                          ]),
              ),
      ),
    ));
  }
}
