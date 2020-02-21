import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewyorktTimes extends StatefulWidget {
  List list;
  NewyorktTimes({@required this.list});
  @override
  _NewyorktTimesState createState() => _NewyorktTimesState();
}

class _NewyorktTimesState extends State<NewyorktTimes> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.list.length,
      itemBuilder: (builder, index) {
        return Container(
          margin:
              EdgeInsets.all(MediaQuery.of(context).size.height * 0.25 / 20),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.8 / 30),
          decoration: new BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black87,
                  offset: new Offset(0.0, 2.0),
                  blurRadius: 5.0
                )
              ]),
          width: MediaQuery.of(context).size.width * 0.8,
          height: double.infinity,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height * 0.25 * 5 / 20,
                child: new Text(
                  widget.list[index]["abstract"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: new TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new SizedBox(
                height: MediaQuery.of(context).size.height * 0.25 * 1.4 / 20,
              ),
              new Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.25 * 9.5 / 20,
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        color: Colors.transparent,
                        child: new Text(
                          widget.list[index]["lead_paragraph"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: new TextStyle(color: Colors.blueGrey),
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
                              _launchURL(widget.list[index]["web_url"]);
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
    );
  }
}
