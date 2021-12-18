import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  get validator =>
      (value) => value != null && value.isNotEmpty ? null : 'Required';

  void setIsLoading(bool loadingState) {
    setState(() {
      isLoading = loadingState;
    });
  }

  onPasswordAuth() async {
    if (formKey.currentState?.validate() ?? false) {
      setIsLoading(true);
    }
  }

  onGoogleAuth() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'flutter@fire.com',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onPasswordAuth,
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : Text(mode.label),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: isLoading
                      ? const SizedBox(
                          width: 45,
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        )
                      : SignInButton(
                          Buttons.Google,
                          elevation: 0.8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onPressed: onGoogleAuth,
                        ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                        text: mode == AuthMode.login
                            ? "Don't have an account? "
                            : 'You have an account? ',
                      ),
                      TextSpan(
                        text: mode == AuthMode.login
                            ? 'Register now'
                            : 'Click to login',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              mode = mode == AuthMode.login
                                  ? AuthMode.register
                                  : AuthMode.login;
                            });
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
