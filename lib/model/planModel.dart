class Plan {
  String id;
  String planName;
  String nbrExercises;
  List exercises;
  List nbrsSeries;
  // lista dynamique mch string

//constructor
  Plan({
    this.id = "",
    this.planName = "",
    this.nbrExercises = "",
    this.exercises = const [],
    this.nbrsSeries = const [],
  }); // If warnings is null, initialize it as an empty list
}
