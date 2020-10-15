import 'package:flutter/material.dart';

class ImageModel extends ChangeNotifier {
  int id;
  String title;
  String descripion;
  String length;
  String picture;
  String date;

  ImageModel(
      {this.id,
      this.title,
      this.descripion,
      this.length,
      this.picture,
      this.date});

  factory ImageModel.fromJson(Map<String, dynamic> parsedJson) => ImageModel(
        id: parsedJson["id"],
        title: parsedJson["title"] as String,
        descripion: parsedJson["descripion"] as String,
        length: parsedJson["length"] as String,
        picture: parsedJson["picture"] as String,
        date: parsedJson["date"] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['descripion'] = this.descripion;
    data['picture'] = this.picture;
    data['length'] = this.length;
    data['date'] = this.date;
    return data;
  }
}
