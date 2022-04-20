import 'package:flutter/material.dart';
import 'package:secure_app/pages/sign_in.dart';
import 'package:secure_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final User user;
  static const String id = "home";
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authClient = AuthClient();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authenticated User\n\nUID: ${widget.user.uid}\nName: ${widget.user.displayName}\nEmail: ${widget.user.email}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _isEditing
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isEditing = false;
                        });
                        await _authClient.signOut();
                        setState(() {
                          _isEditing = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
