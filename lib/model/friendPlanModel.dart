class Friendplan {
  String id;
  String planName;
  String userId;
  String planFrom;
  String nbrExercises;
  List exercises;
  List nbrsSeries;
  // lista dynamique mch string

//constructor
  Friendplan({
    this.id = "",
    this.planName = "",
    this.nbrExercises = "",
    this.exercises = const [],
    this.nbrsSeries = const [],
    this.userId = "",
    this.planFrom = "",
  }); // If warnings is null, initialize it as an empty list
}
