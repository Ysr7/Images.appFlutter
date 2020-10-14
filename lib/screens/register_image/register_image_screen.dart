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

  String sizeImage;

  String imageBase64;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);

        sizeImage = ImageSizeGetter.getSize(FileInput(imageFile)) as String;
        
        List<int> imageBytes = imageFile.readAsBytesSync();
        imageBase64 = base64Encode(imageBytes);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Cadastrar Imagem"),
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
                          // _pickImageFromCamera();
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
                        onSaved: (title) => image.descripion = title,
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

                                    imageService.register(
                                        model: image,
                                        onSuccess: () {
                                          Navigator.of(context).pop();
                                        },
                                        onFail: (e) {
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Falha ao cadastrar: $e"),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
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
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 50),
      child:
          this.imageFile == null ? Placeholder() : Image.file(this.imageFile),
    );
  }
}
