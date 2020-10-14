import 'package:Images_App/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/image_list_tile.dart';
import 'components/search_dialog.dart';

class HomeScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Consumer<ImageService>(builder: (_, imageService, __) {
          if (imageService.search.isEmpty) {
            return const Text("Images");
          } else {
            return LayoutBuilder(builder: (_, constraints) {
              return GestureDetector(
                onTap: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(imageService.search));
                  if (search != null) {
                    imageService.search = search;
                  }
                },
                child: Container(
                    width: constraints.biggest.width,
                    child: Text(
                      imageService.search,
                      textAlign: TextAlign.center,
                    )),
              );
            });
          }
        }),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ImageService>(
            builder: (_, imageService, __) {
              if (imageService.search.isEmpty) {
                return IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(imageService.search));
                      if (search != null) {
                        imageService.search = search;
                      }
                    });
              } else {
                return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      imageService.search = "";
                    });
              }
            },
          )
        ],
      ),
      body: Consumer<ImageService>(
        builder: (_, imageService, __) {
          final filteredProducts = imageService.filteredImages;
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: imageService.filteredImages.length,
              itemBuilder: (_, index) {
                return ImageListTile(imageService.filteredImages[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/register_image");
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
