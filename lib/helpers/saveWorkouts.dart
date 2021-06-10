import 'package:flutter/foundation.dart';
import 'package:virtualfitnesstrainer/models/exercise.dart';
import 'db_helper.dart';

class Saveworkouts with ChangeNotifier {
  List<String> _namesOfSaveWorkoutList = [];

  List<String> get saveWorkoutList {
    return [..._namesOfSaveWorkoutList];
  }

  List<Exercise> _exercises = [];

  List<Exercise> get exerciseslist {
    return [..._exercises];
  }

  Future<void> addItemToList(String wkout) async {
    _namesOfSaveWorkoutList.add(wkout);
    //save into db
    await DBHelper.insertSaveWorkoutListName('EList', {'listTitle': wkout});

    notifyListeners();
  }

  Future<void> addExerciseToList(String listname, Exercise exe) async {
    //save into db
    await DBHelper.insertExercise('SaveExercises', {
      'title': exe.title,
      'imgurl': exe.imgurl,
      'videoUrlID': exe.videoUrlID,
      'description': exe.description,
      'listTitle': listname,
      'isPresentInSaveWorkout': exe.iPresentinSaveWorkout.toString()
    });

    notifyListeners();
  }

  Future<void> fetchList() async {
    final alldata = await DBHelper.getList('EList');
    _namesOfSaveWorkoutList =
        alldata.map((e) => e['listTitle'].toString()).toList();

    notifyListeners();
  }

  Future<void> fetchExercisesInList(String listName) async {
    final allexercises =
        await DBHelper.getDataInTheList('SaveExercises', listName.toString());
    if (allexercises.isNotEmpty) print(allexercises.length);
    print('i am here2');

    _exercises = allexercises.map((e) {
      bool check = false;
      if (e['isPresentInSaveWorkout'].toString().toLowerCase() == 'true') {
        check = true;
      }
      return Exercise(
          title: e['title'],
          imgurl: e['imgurl'],
          videoUrlID: e['videoUrlID'],
          description: e['description'],
          iPresentinSaveWorkout: check);
    }).toList();
    print(_exercises.length);
    print('iioooiii22');
    notifyListeners();
  }

  // void removeitemtoList(int index) {
  //   _namesOfSaveWorkoutList.removeAt(index);
  //   notifyListeners();
  // }

  Future<void> RemoveExcerciseFromList(String title, String listname) async {
    //_namesOfSaveWorkoutList.add(wkout);
    //save into db
    await DBHelper.removeExcercise('SaveExercises', title, listname);

    notifyListeners();
  }

  Future<void> removelistfromDB(String list) async {
    await DBHelper.removeList('EList', list);
    await fetchList();
    notifyListeners();
  }
}
