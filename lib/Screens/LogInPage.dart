import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medical_app/Screens/SignUpPage.dart';
import 'package:medical_app/Services/Authentication.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Authentication _authentication = new Authentication();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: new Text(
          "Log In",
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: new SafeArea(
          child: ListView(children: [
        new AnimatedContainer(
          duration: new Duration(seconds : 2),
          curve: Curves.bounceInOut,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text(
              "Welcome back ! ",
              style: new TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: new Stack(
            children: <Widget>[
              new Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.indigo,
                          offset: new Offset(0.0, -5.0)
                        ),
                        new BoxShadow(
                            color: Colors.indigo, offset: new Offset(0.0, 5.0))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Form(
                      key: _formKey,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new TextFormField(
                            validator: (value) =>
                                value.isEmpty ? "Enter an email first" : null,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: new InputDecoration(
                                icon: Icon(
                                  Icons.alternate_email,
                                  color: Colors.black,
                                ),
                                labelText: "Email",
                                hintText: 'example@gmail.com',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black))),
                          ),
                          new TextFormField(
                            validator: (value) => value.length < 6
                                ? "It should be of six characters"
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            decoration: new InputDecoration(
                                icon: Icon(
                                  Icons.keyboard,
                                  color: Colors.black,
                                ),
                                labelText: "Password",
                                hintText: 'First see there is no one around .',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black))),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 60.0,
                            child: new RaisedButton(
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result = await _authentication
                                      .signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      if (error == '')
                                        error = "No matching credentials found";
                                      else
                                        error = '';
                                    });
                                  } else {
                                    // It get directly reach to the HomePage() as we have set a Stream at the Wrapper Class .
                                  }
                                }
                              },
                              child: new Text(
                                "Log in",
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          new Text(
                            error,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.red.shade700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text("Don't have an account ?",
                                  style: new TextStyle(
                                      color: Colors.blueGrey.shade600,
                                      fontSize: 15.0)),
                              new InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPAge()),
                                  );
                                },
                                child: new Text("Create an account",
                                    style: new TextStyle(
                                        color: Colors.blue, fontSize: 15.0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Center(
          child: new Text(
            "Hosted on Github with ❤ by Abhishek",
            style: new TextStyle(
                color: Colors.blueGrey,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ])),
    );
  }
}
