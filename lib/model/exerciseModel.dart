class Exercise {
  String id;
  String bodyPart;
  String name;
  String image;
  String video;
  String description;
  List<String> instructions;
  List<String> warnings;

//constructor
  Exercise({
    this.id = "",
    this.bodyPart = "",
    this.name = "",
    this.image = "",
    this.video = "",
    this.description = "",
    this.instructions = const [],
    this.warnings = const [],
  }); // If warnings is null, initialize it as an empty list
}
