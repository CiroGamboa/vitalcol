import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
