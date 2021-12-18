import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/views/models/gallery_view_model.dart';
import '../views/view_image_viewer.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  onImageTap(BuildContext context, int index) {
    final gallery = context.read<GalleryViewModel>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: gallery,
          builder: (context, _) {
            return ImageViewerView(image: images[index]);
          },
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onImageTap(context, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              child: FittedBox(
                child: images[index].contains('http')
                    ? Image.network(images[index])
                    : Image.file(File(images[index])),
                fit: BoxFit.cover,
              ),
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        );
      },
    );
  }
}
