import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/Services/Authentication.dart';

class SignUpPAge extends StatefulWidget {
  SignUpPAge({Key key}) : super(key: key);

  @override
  _SignUpPAgeState createState() => _SignUpPAgeState();
}

class _SignUpPAgeState extends State<SignUpPAge> {
  Authentication _authentication = new Authentication();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: new Text(
          "Sign Up",
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: new SafeArea(
          child: ListView(children: [
        new AnimatedContainer(
          duration: new Duration(seconds: 2),
          curve: Curves.bounceInOut,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text(
              "We need some of your credentials ",
              style: new TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo),
            ),
          ),
        ),
        new Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: new Stack(
            children: <Widget>[
              new Center(
                child: new Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.indigo,
                            offset: new Offset(0.0, -5.0)),
                        new BoxShadow(
                            color: Colors.indigo, offset: new Offset(0.0, 5.0)),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Form(
                      key: _formKey,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new TextFormField(
                            validator: (value) => value.isEmpty
                                ? "Enter your Username first"
                                : null,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: new InputDecoration(
                                icon: Icon(
                                  Icons.person_pin,
                                  color: Colors.black,
                                ),
                                labelText: "Username",
                                hintText: 'What we call you ? ',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black))),
                          ),
                          new TextFormField(
                            validator: (value) =>
                                value.isEmpty ? "Enter your email first" : null,
                            inputFormatters: <TextInputFormatter>[],
                            onChanged: (value) {
                              setState(() {
                                _email = value;
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
                            validator: (value) => value.length < 10
                                ? "Enter a valid phone number"
                                : null,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {},
                            decoration: new InputDecoration(
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.black,
                                ),
                                labelText: "Phone Number",
                                hintText: '+91 XXXX XXXX XX',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.black))),
                          ),
                          new TextFormField(
                            validator: (value) => value.length < 6
                                ? "Password must be of 6 characters"
                                : null,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
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
                            height: 70.0,
                            width: MediaQuery.of(context).size.width,
                            child: new RaisedButton(
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result = await _authentication
                                      .registerWithEmailAndPassword(
                                          _email, _password);
                                  if (result != null) {
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      if (error == '')
                                        error = 'Please supply a valid email';
                                      else
                                        error = '';
                                    });
                                  }
                                }
                              },
                              child: new Text(
                                "Signup",
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
                              color: Colors.red.shade800,
                            ),
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
