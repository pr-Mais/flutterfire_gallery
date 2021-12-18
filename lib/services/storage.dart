import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  StorageService() {
    getImages();
  }

  final _storage = FirebaseStorage.instance;

  Map<String, Reference> refs = {};

  Reference get galleryRef => _storage
      .ref()
      .child('gallery')
      .child('${FirebaseAuth.instance.currentUser?.uid}');

  StreamController<String?> streamGalleryController =
      StreamController<String?>.broadcast();

  Stream<String?> streamGallery() {
    return streamGalleryController.stream;
  }

  Future uploadImage(XFile image) async {
    try {
      await galleryRef.child(image.name).putData(await image.readAsBytes());
    } on FirebaseException {
      rethrow;
    }
  }

  void getImages() async {
    ListResult result = await galleryRef.listAll();

    for (var ref in result.items) {
      final url = await ref.getDownloadURL();
      refs[url] = ref;

      streamGalleryController.add(url);
    }
  }

  Future delete(String image) async {
    await refs[image]!.delete();
    refs.remove(image);
  }
}
