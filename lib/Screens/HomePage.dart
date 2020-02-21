import 'dart:convert';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_app/Models/MyIcons.dart';
import 'package:medical_app/Screens/ChatBot.dart';
import 'package:medical_app/Screens/CureDetails.dart';
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
  var _selectedIndex = 0;
  var _currentNav = 0 ;
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
      backgroundColor: Colors.white,
      body: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
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
            color: Colors.indigo,
            height: 2.0,
          ),
          new Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: _loadingHeadlines
                  ? new Center(child: new CircularProgressIndicator())
                  : NewyorktTimes(list: list)),
          new Expanded(
              child: Container(
                color: Colors.white,
                child: new GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(9, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CureDetails(
                                      name: dataext[index],
                                      bigImage: bigImageURLS[index],
                                    )));
                      },
                      child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 3 * 0.04),
                          margin: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 3 * 0.030),
                          child: Hero(
                            tag: dataext[index],
                            child: new Container(
                              decoration: new BoxDecoration(
                                  color: Colors.indigo.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: <BoxShadow>[
                                    new BoxShadow(
                                      color: Colors.black,
                                      offset: new Offset(0.0, 2.0),
                                      blurRadius: 5.0
                                    )
                                  ]
                                  ),
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ext[index],
                                  new Text(
                                    dataext[index],
                                    style: new TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  }),
                ),
              )),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.redAccent.shade700,
        child: new Icon(FontAwesomeIcons.ambulance),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: new BottomNavigationBar(
      //   unselectedFontSize: 14.0,
      //   iconSize: 30.0,
      //   currentIndex: _selectedIndex,
      //   fixedColor: Colors.indigo,
      //   onTap: (newIndex) {
      //     setState(() {
      //       _selectedIndex = newIndex;
      //     });
      //   },
      //   items: <BottomNavigationBarItem>[
      //     new BottomNavigationBarItem(
      //         icon: new Icon(Icons.home), title: new Text("Home")),
      //     new BottomNavigationBarItem(
      //         icon: new Icon(Icons.add_location), title: new Text("Chat Bot")),
      //   ],
      // ),
      bottomNavigationBar: new BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Container(
          //color: Colors.indigoAccent,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.home),onPressed: () {
                setState(() {
                  _currentNav = 0 ;
                });
              },iconSize: 40.0,
              color: _currentNav == 0 ?Colors.indigoAccent : Colors.black,
              ),
              new IconButton(icon: new Icon(Icons.chat),onPressed: () {
                setState(() {
                  _currentNav = 0;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));
                });
              },iconSize: 40.0,
              color: _currentNav == 1 ? Colors.indigoAccent : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
