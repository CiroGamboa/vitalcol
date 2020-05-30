import 'package:flutter/material.dart';
import 'package:vitalcol2020/screens/calendarScreen.dart';
import 'package:vitalcol2020/screens/cameraScreen.dart';
import 'package:vitalcol2020/screens/configScreen.dart';
import 'package:vitalcol2020/screens/homeScreen.dart';
import 'package:vitalcol2020/screens/loginScreen.dart';
import 'package:vitalcol2020/screens/registerScreen.dart';
import 'package:vitalcol2020/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'VitalCol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => SplashScreen(),
  '/login': (BuildContext context) => LoginScreen(),
  '/register': (BuildContext context) => RegisterScreen(),
  '/home': (BuildContext context) => HomeScreen(),
  '/camera': (BuildContext context) => CameraScreen(),
  '/calendar': (BuildContext context) => CalendarScreen(),
  '/config': (BuildContext context) => ConfigScreen(),
};
