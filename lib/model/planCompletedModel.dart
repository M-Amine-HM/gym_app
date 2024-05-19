class PlanCompleted {
  String id;
  String planName;
  String nbrExercises;
  List exercises;
  List nbrsSeries;
  List<List<dynamic>> seriesCompleted;
  String time;
  // lista dynamique mch string

//constructor
  PlanCompleted({
    this.id = "",
    this.planName = "",
    this.nbrExercises = "",
    this.time = "",
    this.exercises = const [],
    this.nbrsSeries = const [],
    this.seriesCompleted = const [
      [[]]
    ],
  }); // If warnings is null, initialize it as an empty list
}
