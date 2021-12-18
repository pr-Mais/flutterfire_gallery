import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/views/models/gallery_view_model.dart';
import '../widgets/widget_image_grid_view.dart';

class MyGalleryView extends StatefulWidget {
  const MyGalleryView({Key? key}) : super(key: key);

  @override
  _MyGalleryViewState createState() => _MyGalleryViewState();
}

class _MyGalleryViewState extends State<MyGalleryView> {
  @override
  Widget build(BuildContext context) {
    final gallery = context.watch<GalleryViewModel>();

    return ImageGridView(
      images: gallery.myImages,
    );
  }
}
