import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> animation;

  startTimer() {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigatorPage);
  }

  navigatorPage() {
    FirebaseAuth.instance.currentUser().then((currentUser) =>
    (currentUser == null)
        ? Navigator.pushReplacementNamed(context, "/login")
        : Navigator.pushReplacementNamed(context, '/home')
    ).catchError((err) => print(err));
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();
    startTimer();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ScaleTransition(
              scale: animation,
              child: Hero(
                tag: "logo",
                child: Container(
                  color: Colors.transparent,
                  width: 250.0,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}