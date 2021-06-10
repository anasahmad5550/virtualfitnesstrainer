import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/screens/exerciseVideoScreen.dart';

class ExerciseContainer extends StatelessWidget {
  final String title;
  final List muscle;
  final String imgurL;
  final String listName;

  ExerciseContainer({this.title, this.imgurL, this.muscle, this.listName});

  void pushexerciseVideo(BuildContext context, String exercName) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return ExerciseVideoScreen(
          listName: listName,
          exerciseName: exercName,
          muscleName: muscle,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushexerciseVideo(context, title),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'images/exerciseImages/' + imgurL,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).accentColor),
      ),
    );
  }
}
