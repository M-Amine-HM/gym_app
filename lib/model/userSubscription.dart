class UserSubscription {
  String id;
  String userId;
  String email;
  String gymName;
  String subscription;
  String daysLeft;
  List entries;
  List exits;

//constructor
  UserSubscription({
    this.id = "",
    this.gymName = "",
    this.email = "",
    this.subscription = "",
    this.daysLeft = "",
    this.entries = const [],
    this.exits = const [],
    this.userId = "",
  });
}
