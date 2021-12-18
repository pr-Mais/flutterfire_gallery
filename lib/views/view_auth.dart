import 'package:flutter/material.dart';

/// The mode of the current auth session, either [AuthMode.login] or [AuthMode.register].
enum AuthMode { login, register }

extension on AuthMode {
  String get label => this == AuthMode.login ? 'Login' : 'Register';
}

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  // We want to start initially from the login mode.
  AuthMode mode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logo.png',
                scale: 1.5,
              ),
              const SizedBox(height: 20),
              Text(
                'FlutterFire \nGallery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
