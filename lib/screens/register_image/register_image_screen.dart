import 'dart:convert';
import 'dart:io';

import 'package:Images_App/models/image.dart';
import 'package:Images_App/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:full_screen_image/full_screen_image.dart';

class RegisterImageScreen extends StatefulWidget {
  @override
  _RegisterImageScreen createState() => _RegisterImageScreen();
}

class _RegisterImageScreen extends State<RegisterImageScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ImageModel image = ImageModel();

  final picker = ImagePicker();

  File imageFile;

  String imageBase64;

  int heightSizeImage;
  int widthSizeImage;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);

        Size sizeImage = ImageSizeGetter.getSize(FileInput(imageFile));

        heightSizeImage = sizeImage.height;
        widthSizeImage = sizeImage.width;

        List<int> imageBytes = imageFile.readAsBytesSync();
        imageBase64 = base64Encode(imageBytes);

        image.picture = imageBase64;
        image.length =
            (heightSizeImage.toString() + 'x' + widthSizeImage.toString())
                .toString();
      } else {
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Cadastrar imagen"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
              key: formKey,
              child: Consumer<ImageService>(
                builder: (_, imageService, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      placeHolder(),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: Text(
                          "Tirar foto",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Título da foto"),
                        enabled: !imageService.loading,
                        validator: (title) {
                          if (title.isEmpty) {
                            return "Campo obrigatório";
                          } else if (title.length <= 5) {
                            return "Título da foto muito pequeno!";
                          }
                          return null;
                        },
                        onSaved: (title) => image.title = title,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Descrição da foto"),
                        enabled: !imageService.loading,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (descripion) {
                          if (descripion.isEmpty) {
                            return "Campo obrigatório";
                          } else if (descripion.length <= 5) {
                            return "Descrição da foto muito pequeno!";
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        onSaved: (descripion) => image.descripion = descripion,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          color: Colors.green,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: imageService.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    if (imageFile != null) {
                                      imageService.register(
                                          model: image,
                                          onSuccess: () {
                                            Navigator.of(context).pop();
                                          },
                                          onFail: (e) {
                                            scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Falha ao cadastrar: $e"),
                                              backgroundColor: Colors.red,
                                            ));
                                          });
                                    } else {
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "É obrigatorio tirar uma foto!"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  }
                                },
                          child: imageService.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  "Enviar foto",
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  Widget placeHolder() {
    return FullScreenWidget(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: this.imageFile == null ? null : Image.file(this.imageFile),
      ),
    );
  }
}
