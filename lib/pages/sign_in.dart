import 'package:flutter/material.dart';
import 'package:secure_app/pages/home.dart';
import 'package:secure_app/pages/sign_up.dart';
import 'package:secure_app/services/auth.dart';
import 'package:secure_app/services/validation.dart';
import 'package:secure_app/widgets/email_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  static const String id = "signIn";
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _authClient = AuthClient();
  bool _isEditing = false;

  late String _passST;
  double _strength = 0;
  String _displayText =
      'Enter your password with at least 1 of each of the following:\n\n-UpperCase, \n\n-lowerCase, \n\n-number and \n\n-Special character';

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void _checkPassword(String value) {
    _passST = value.trim();

    if (_passST.isEmpty) {
      setState(() {
        _strength = 0;
        _displayText =
            'Please enter you password, must contain at least 1 of each of the following:\n\n-UpperCase, \n\n-lowerCase, \n\n-number and \n\n-Special character';
      });
    } else if (_passST.length < 6) {
      setState(() {
        _strength = 1 / 4;
        _displayText = 'Your password is too short';
      });
    } else if (_passST.length < 8) {
      setState(() {
        _strength = 2 / 4;
        _displayText = 'Your password is acceptable but not strong';
      });
    } else {
      if (!letterReg.hasMatch(_passST) || !numReg.hasMatch(_passST)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          _strength = 3 / 4;
          _displayText = 'Your password is strong';
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          _displayText = 'Your password is great';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailField(
                    emailController: _emailController,
                    emailFocusNode: _emailFocusNode),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: Validation.password,
                  onChanged: (val) => _checkPassword(val),
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                    label: Text('Password'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _isEditing
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            LinearProgressIndicator(
                              value: _strength,
                              backgroundColor: Colors.grey[300],
                              color: _strength <= 1 / 4
                                  ? Colors.red
                                  : _strength == 2 / 4
                                      ? Colors.yellow
                                      : _strength == 3 / 4
                                          ? Colors.blue
                                          : Colors.green,
                              minHeight: 15,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              _displayText,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: _strength < 1 / 2
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isEditing = true;
                                        });

                                        final User? user =
                                            await _authClient.login(
                                                _emailController.text,
                                                _passwordController.text);

                                        setState(() {
                                          _isEditing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Home(user: user),
                                            ),
                                            (route) => false,
                                          );
                                        }
                                      }
                                    },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account?',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
