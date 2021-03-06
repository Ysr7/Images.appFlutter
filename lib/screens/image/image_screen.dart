import 'dart:convert';
import 'package:Images_App/models/image.dart';
import 'package:Images_App/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ImageScreem extends StatelessWidget {
  const ImageScreem(this.image);

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final Widget okButton = FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("OK"),
    );

    return ChangeNotifierProvider.value(
        value: image,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(image.title),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1,
                  child: FullScreenWidget(
                    child: ClipRRect(
                      child: Image.memory(
                        base64Decode(image.picture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: new Icon(
                              AntDesign.like1,
                              color: Colors.green,
                              size: 50,
                            ),
                            onPressed: () {
                              //configura o AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Você deu like nessa foto!"),
                                actions: [
                                  okButton,
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }),
                        IconButton(
                            icon: new Icon(
                              AntDesign.dislike1,
                              color: Colors.red,
                              size: 50,
                            ),
                            onPressed: () {
                              AlertDialog alert = AlertDialog(
                                title: Text("Você deu dislike nessa foto!"),
                                actions: [
                                  okButton,
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                      image.length,
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
                          Widget cancelaButton = FlatButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continuaButton = FlatButton(
                            child: Text("Confirmar"),
                            onPressed: () {
                              Provider.of<ImageService>(context, listen: false)
                                  .delete(image.id);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          );
                          //configura o AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Excluir"),
                            content: Text("Deseja excluir essa imagem?"),
                            actions: [
                              cancelaButton,
                              continuaButton,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
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
