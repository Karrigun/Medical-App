import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_app/Services/Authentication.dart';
import 'package:medical_app/Widgets/LocationSearch.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _launchURL(url) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // data();
    // status();
    if (_first) {
      _fetchHeadlines();
      setState(() {
        _first = false ;
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
                : new ListView.builder(
                    scrollDirection: Axis.horizontal,
                     itemCount: list.length,
                    itemBuilder: (builder, index) {
                      return Container(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.25 / 20),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.8 / 30),
                        decoration: new BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: double.infinity,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              height: MediaQuery.of(context).size.height *
                                  0.25 *
                                  5 /
                                  20,
                              child: new Text(
                                list[index]["abstract"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: new TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            new SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.25 *
                                  1.4 /
                                  20,
                            ),
                            new Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height *
                                  0.25 *
                                  9.5 /
                                  20,
                              child: new Column(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Container(
                                      color: Colors.transparent,
                                      child: new Text(
                                        list[index]["lead_paragraph"],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: new TextStyle(
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: new RaisedButton(
                                          onPressed: () {
                                            _launchURL(list[index]["web_url"]);
                                          },
                                          color: Colors.indigoAccent,
                                          child: new Text(
                                            "Read More",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
