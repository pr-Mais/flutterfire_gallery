import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/shared_prefs.dart';
import 'views/view_auth.dart';
import 'views/view_home.dart';
import 'theme/theme_provider.dart';

/// Temporarily we will use this const to mimic the state of user.
/// true = there's a signed in user
/// false = no signed in user
const bool kUser = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsService.instance.init();

  runApp(const GalleryApp());
}

/// The entry point of Gallery app
class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FlutterFireTheme>(
        create: (_) => FlutterFireTheme(),
        builder: (context, __) {
          final lightTheme = context
              .select<FlutterFireTheme, ThemeData>((theme) => theme.lightTheme);
          final darkTheme = context
              .select<FlutterFireTheme, ThemeData>((theme) => theme.darkTheme);
          final currentTheme = context.select<FlutterFireTheme, ThemeMode>(
              (theme) => theme.currentTheme);
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: currentTheme,
            home: const AuthGate(),
          );
        });
  }
}

/// The entry point which decides the view basd on user auth state.
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kUser ? const HomeView() : const AuthView();
  }
}
