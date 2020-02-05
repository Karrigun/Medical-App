import 'package:flutter/material.dart';
import 'dart:async';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Expanded(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          Center(
            child: new Image(
              width: 100,
              height: 100,
              image: AssetImage(
                "assets/images/heart_medical.png",
              ),
              fit: BoxFit.contain,
            ),
          ),
          new Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: 10.0,
            child: new Center(
              child: new Text(
                "Hosted on Github with ❤ by Abhishek",
                style: new TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
