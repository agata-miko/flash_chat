import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/rounded_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter an email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter a password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      color: Colors.blueAccent,
                      onPress: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null) {Navigator.pushNamed(context, ChatScreen.id);}
                          setState(() {
                            showSpinner = false;
                          });
                        }
                        catch (e) {
                          print(e);
                        }
                      },
                      text: 'Register'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
