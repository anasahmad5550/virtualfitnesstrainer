import 'package:flutter/services.dart';
import 'package:virtualfitnesstrainer/helpers/saveWorkouts.dart';
import 'package:virtualfitnesstrainer/models/exercise.dart';
import 'package:virtualfitnesstrainer/screens/saveWorkoutsScreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ExerciseVideoScreen extends StatefulWidget {
  final String exerciseName;
  final List muscleName;
  final String listName;
  ExerciseVideoScreen({this.exerciseName, this.muscleName, this.listName});
  @override
  _ExerciseVideoScreenState createState() => _ExerciseVideoScreenState();
}

class _ExerciseVideoScreenState extends State<ExerciseVideoScreen> {
  String descriptionEx;
  String id;
  bool checkpresentInSaveWorkout;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  Exercise AddedExercise() {
    Exercise e = widget.muscleName
        .firstWhere((element) => widget.exerciseName == element.title);
    e.iPresentinSaveWorkout = true;
    return e;
  }

  Exercise selectDescriptionAndVideoUrl() {
    return widget.muscleName
        .firstWhere((element) => widget.exerciseName == element.title);
  }

  @override
  void initState() {
    descriptionEx = selectDescriptionAndVideoUrl().description;
    id = selectDescriptionAndVideoUrl().videoUrlID;
    checkpresentInSaveWorkout =
        selectDescriptionAndVideoUrl().iPresentinSaveWorkout;
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  void AddOrRemove() async {
    _controller.pause();
    if (!checkpresentInSaveWorkout) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveWorkoutsScreen(
            exercise: AddedExercise(),
          ),
        ),
      );
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text('${AddedExercise().title} is Added'),
      // ));

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('${AddedExercise().title} is Added'),
      // ));
    } else {
      await Provider.of<Saveworkouts>(context, listen: false)
          .RemoveExcerciseFromList(widget.exerciseName, widget.listName);
      var nav = Navigator.of(context);
      nav.pop();
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    descriptionEx = selectDescriptionAndVideoUrl().description;
    return Scaffold(
      body: YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.

          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _controller.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
          // onEnded: (data) {
          //   _controller
          //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          //   _showSnackBar('Next Video Started!');
          // },
        ),
        builder: (context, player) => Scaffold(
          key: _scaffoldKey,
          appBar: CupertinoNavigationBar(
            backgroundColor: Theme.of(context).canvasColor,
            trailing: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RaisedButton(
                child: Text(checkpresentInSaveWorkout ? 'Remove' : 'Add'),
                onPressed: AddOrRemove,
                textColor: Colors.white,
                color: Color(0xffFB376C),
              ),
            ),
            middle: FittedBox(
              child: Text(
                widget.exerciseName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'How to do...',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        descriptionEx,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _text(String title, String value) {
  //   return RichText(
  //     text: TextSpan(
  //       text: '$title : ',
  //       style: const TextStyle(
  //         color: Colors.blueAccent,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       children: [
  //         TextSpan(
  //           text: value ?? '',
  //           style: const TextStyle(
  //             color: Colors.blueAccent,
  //             fontWeight: FontWeight.w300,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget get _space => const SizedBox(height: 10);
}
