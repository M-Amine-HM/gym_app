class PlanCompleted {
  String id;
  String planName;
  String nbrExercises;
  List exercises;
  List nbrsSeries;
  List<dynamic> seriesCompleted;
  String time;
  String currentTime;
  String userId;

  // lista dynamique mch string

//constructor
  PlanCompleted({
    this.id = "",
    this.userId = "",
    this.planName = "",
    this.nbrExercises = "",
    this.time = "",
    this.currentTime = "",
    this.exercises = const [],
    this.nbrsSeries = const [],
    this.seriesCompleted = const [
      [[]]
    ],
  }); // If warnings is null, initialize it as an empty list
}
