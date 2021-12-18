import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';

import 'models/gallery_view_model.dart';

class ImageViewerView extends StatelessWidget {
  const ImageViewerView({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final gallery = context.read<GalleryViewModel>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_rounded),
            onPressed: () async {
              Navigator.of(context).pop();
              await gallery.deleteImage(image);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image deleted.'),
                ),
              );
            },
          ),
        ],
      ),
      body: image.contains('http')
          ? PhotoView(
              imageProvider: NetworkImage(image),
            )
          : image.contains('assets')
              ? PhotoView(
                  imageProvider: AssetImage(image),
                )
              : PhotoView(
                  imageProvider: FileImage(File(image)),
                ),
    );
  }
}
