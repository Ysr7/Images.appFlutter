class Image {
  int id;
  String descripion;
  int length;
  String picture;

  Image({this.id, this.descripion, this.length, this.picture});

  factory Image.fromJson(Map<String, dynamic> parsedJson) {
    return Image(
      id: parsedJson["id"],
      descripion: parsedJson["descripion"] as String,
      length: parsedJson["length"],
      picture: parsedJson["picture"] as String,
    );
  }
}
