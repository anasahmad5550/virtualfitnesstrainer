import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/widgets/exerciseContainer.dart';
import 'package:flutter/cupertino.dart';

class ExerciseScreen extends StatelessWidget {
  final List musclename;
  final String muscleCategory;
  ExerciseScreen({@required this.musclename, this.muscleCategory});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).canvasColor,
        trailing: Icon(Icons.search),
        middle: Text(
          muscleCategory,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        children: musclename
            .map((e) => ExerciseContainer(
                  title: e.title,
                  imgurL: e.imgurl,
                  muscle: musclename,
                ))
            .toList(),
      ),
    );
  }
}
