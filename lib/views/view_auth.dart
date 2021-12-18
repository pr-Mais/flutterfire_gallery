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
    return const Scaffold(
      body: Center(
        child: Text("Auth View"),
      ),
    );
  }
}
