import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import './registration_screen.dart';
import './login_screen.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

//curved animation
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
// bouncing animation
//     animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(
    //       from: 1.0,
    //     );
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    LoginScreen.id,
                  );
                  //Go to registration screen.
                },
                text: 'Log in'),
            RoundedButton(
                color: Colors.blueAccent,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    RegistrationScreen.id,
                  );
                  //Go to registration screen.
                },
                text: 'Register'),
          ],
        ),
      ),
    );
  }
}
