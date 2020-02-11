import 'dart:convert';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_app/Models/MyIcons.dart';
import 'package:medical_app/Services/Authentication.dart';
import 'package:medical_app/Widgets/LocationSearch.dart';
import 'package:medical_app/Widgets/NewyorkTimes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Authentication _auth = new Authentication();
  List list = List();
  bool _loadingHeadlines = true;
  bool _first = true;

  void data() async {
    HttpClient()
        .getUrl(Uri.parse(
            'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=health&api-key=iR2qGg5zu2dbu24VmO1bx0oJsZmUbzCQ')) // produces a request object
        .then((request) => request.close()) // sends the request
        .then((response) => response
            .transform(Utf8Decoder())
            .listen(print)); // transforms and prints the response
  }

  void status() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    print(geolocationStatus);
  }

  void _fetchHeadlines() async {
    setState(() {
      _loadingHeadlines = true;
    });
    http.Response response = await http.get(
      "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=health&api-key=JnbxLzZoceKGL8vV0kjIJsE8GeakvmbA",
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      Map decode = json.decode(response.body);
      list = decode["response"]["docs"];
      // for (var res in list) {
      //   print(res["abstract"]);
      // }
      setState(() {
        _loadingHeadlines = false;
      });
    } else {
      throw Exception("Failed to load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    // data();
    // status();
    if (_first) {
      _fetchHeadlines();
      setState(() {
        _first = false;
      });
    }
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width,
            child: new SafeArea(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(
                      iconSize: 35.0,
                      icon: new Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  LocationSearch(),
                ],
              ),
            ),
          ),
          new Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Colors.indigo,
              child: _loadingHeadlines
                  ? new Center(child: new CircularProgressIndicator())
                  : NewyorktTimes(list: list)),
          new Expanded(
              flex: 5,
              child: Container(
                color: Colors.indigo,
                child: new GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(9, (index) {
                    return Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 3 * 0.04),
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 3 * 0.030),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ext[index],
                              new Text(dataext[index],
                              style: new TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                              )
                            ],
                          ),
                        )
                    );
                  }),
                ),
              )),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: new Icon(FontAwesomeIcons.ambulance),
      ),
    );
  }
}
