import 'package:flutter/material.dart';

class PlacesCard extends StatelessWidget {
  String placeName;
  String streetName;
  var rating;
  PlacesCard(
      {@required this.placeName,
      @required this.streetName,
      @required this.rating});

  Widget _rating(var n) {
    String text = '';
    for (int i = 0; i < n; i++) {
      text = text + '⭐';
    }
    return new Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            offset: new Offset(2.0, 3.0),
            blurRadius: 5.0
            )
        ]
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 1 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            placeName,
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.black),
          ),
          new Text(
            placeName,
            style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.blueGrey),
          ),
          _rating(rating)
        ],
      ),
    );
  }
}
