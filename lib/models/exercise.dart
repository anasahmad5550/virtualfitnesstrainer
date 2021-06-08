class Exercise {
  final String imgurl;
  final String title;
  final String videoUrlID;
  final String description;
  bool iPresentinSaveWorkout;

  Exercise(
      {this.title,
      this.imgurl,
      this.videoUrlID,
      this.description,
      this.iPresentinSaveWorkout = false});
}
