import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/models/exercise.dart';
import 'exerciseScreen.dart';
import 'package:virtualfitnesstrainer/exerciseList.dart';

class ExerciseMuscleGroupScreen extends StatefulWidget {
  @override
  _ExerciseMuscleGroupScreenState createState() =>
      _ExerciseMuscleGroupScreenState();
}

class _ExerciseMuscleGroupScreenState extends State<ExerciseMuscleGroupScreen> {
  Expanded tile(String img, String name, List<Exercise> muscle) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return ExerciseScreen(
              musclename: muscle,
              muscleCategory: name,
            );
          }));
        },
        //code here
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red[500],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Opacity(
                    opacity: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage('$img'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      '$name',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xffFB376C),
                    thickness: 3.0,
                    endIndent: 200.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1D0E36),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Text('Muscle Group',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    tile('images/chest.jpg', 'Chest', chestList),
                    tile('images/back.jpg', 'Back', backList),
                    tile('images/bicep.jpg', 'Bicep', bicepsList),
                    tile('images/tricep.jpg', 'Tricep', tricepsList),
                    tile('images/shoulder.jpg', 'Shoulder', shoulderList),
                    tile('images/legs.jpg', 'Legs', legsList),
                    tile('images/abs.jpg', 'Abs', absList),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
