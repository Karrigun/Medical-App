import 'package:flutter/material.dart';
import 'package:medical_app/Models/User.dart';
import 'package:medical_app/Services/Authentication.dart';
import 'package:medical_app/Wrapper.dart';
import 'package:provider/provider.dart';

import 'Screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StreamProvider<User>.value(
      value: Authentication().user,
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          cardColor: Color.fromRGBO(203, 219, 230, 1.0),
          secondaryHeaderColor: Color.fromRGBO(195, 211, 221, 1.0)
        ),
        home: SplashScreen(),
      ),
    );
  }
}