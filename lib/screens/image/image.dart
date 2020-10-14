import 'dart:convert';
import 'package:Images_App/models/image.dart';
import 'package:Images_App/services/image_service.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageScreem extends StatelessWidget {
  const ImageScreem(this.image);

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: image,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(image.descripion),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: [
                    Image.memory(base64Decode(image.picture)),
                  ],
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  dotSpacing: 15,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      image.descripion,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Tamanho da imagem:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      image.length.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Data de cadastro:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      new DateFormat.yMMMd().format(DateTime.parse(image.date)),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: () {
                          Provider.of<ImageService>(context, listen: false).delete(image.id);
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Excluir Imagem"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

showAlertDialog2(BuildContext context) {}
