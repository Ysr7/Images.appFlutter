import 'dart:convert';

import 'package:Images_App/models/image.dart';
import 'package:flutter/material.dart';

class ImageListTile extends StatelessWidget {
  const ImageListTile(this.image);

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context).pushNamed("/image", arguments: image);
      // },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.memory(base64Decode(image.picture)),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      image.descripion,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
