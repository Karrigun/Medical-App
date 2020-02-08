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

  Authentication _authentication = new Authentication() ;
  
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: new Text("Log In" , style: new TextStyle(fontSize: 30.0 , fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: new SafeArea(
          child: ListView(children: [
        new SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
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
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).secondaryHeaderColor,
                            Theme.of(context).cardColor,
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(137, 148, 155, 1.0),
                            offset: Offset(7.0, 7.0),
                            blurRadius: 27.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Color.fromRGBO(178, 192, 202, 1.0),
                            offset: Offset(-7.0, -7.0),
                            blurRadius: 27.0,
                            spreadRadius: 1.0),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 60.0,
                                child: new RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () async {
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
                              )
                            ],
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
              new Positioned(
                  top: 15,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: new Image(
                        image: AssetImage('assets/images/patient.png'),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ])),
    );
  }
}
