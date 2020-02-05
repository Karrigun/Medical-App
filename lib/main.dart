import 'package:flutter/material.dart';

import 'Screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(225, 243, 255,1),
        secondaryHeaderColor: Colors.blue
      ),
      home: SplashScreen(),
    );
  }
}