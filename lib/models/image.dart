import 'package:flutter/material.dart';

class ImageModel extends ChangeNotifier {
  int id;
  String descripion;
  int length;
  String picture;
  String date;

  ImageModel({this.id, this.descripion, this.length, this.picture, this.date});

  factory ImageModel.fromJson(Map<String, dynamic> parsedJson) => ImageModel(
        id: parsedJson["id"],
        descripion: parsedJson["descripion"] as String,
        length: parsedJson["length"] as int,
        picture: parsedJson["picture"] as String,
        date: parsedJson["date"] as String,
      );
}
