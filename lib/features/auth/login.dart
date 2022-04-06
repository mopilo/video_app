import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_app/features/videos/presentation/pages/home_page.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State createState() => SignInState();
}

class SignInState extends State<SignIn> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    return Center(
      child: InkWell(
          child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 18,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.black),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/google.png'),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Text(
                    'Sign in with Google',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ))),
          onTap: _handleSignIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
          backgroundColor: Colors.black,
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
