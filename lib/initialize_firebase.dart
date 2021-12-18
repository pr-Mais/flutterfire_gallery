import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterfire_gallery/firebase_options.dart';

const env = String.fromEnvironment('env');

/// A top-level function to initialize [Firebase].
/// If `dev` was passed in `--dart-define=env=dev`, emulators will be used.
///
/// Note that to use emulators, you need to initialize them first:
/// https://firebase.google.com/docs/emulator-suite/install_and_configure
Future initializeFirebase() async {
  // Initialize the default app from Dart
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (env == 'dev') {
    // Use emulators if it's a dev environment
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }
}
