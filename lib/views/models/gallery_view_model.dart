import 'package:flutter/material.dart';
import 'package:flutterfire_gallery/services/storage.dart';
import 'package:image_picker/image_picker.dart';

class GalleryViewModel extends ChangeNotifier {
  final storage = StorageService();

  /// List of current user's images.
  List<String> myImages = [];

  /// Set the initial list of images coming from Storage.
  setMyImages(images) {
    myImages = images;

    notifyListeners();
  }

  /// Use to add images and update the gallery view locally.
  addToMyImages(String image) {
    myImages.add(image);

    notifyListeners();
  }

  uploadToStorage(XFile image) async {
    addToMyImages(image.path);
    await storage.uploadImage(image);
  }

  Future deleteImage(String image) async {
    myImages.remove(image);

    notifyListeners();

    await storage.delete(image);
    storage.streamGalleryController.add(null);
  }
}
