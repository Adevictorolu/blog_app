class Story {
  final String heading;
  final String story;
  final String date;
  final String image;

  Story({
    required this.heading,
    required this.story,
    required this.date,
    required this.image,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      heading: json["heading"],
      story: json["story"],
      date: json["date"],
      image: json["image"],
    );
  }
}
