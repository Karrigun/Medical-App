import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  String currentLocation;
  bool _first = true;
  Future<String> currentLocationName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first.subAdminArea + " , " + address.first.postalCode;
  }

  @override
  Widget build(BuildContext context) {
    if (_first)
      currentLocationName().then((val) {
        setState(() {
          currentLocation = val;
          _first = false;
        });
      });

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Icon(
          Icons.location_on,
          color: Colors.grey,
          size: 35.0,
        ),
        new Container(
          width: MediaQuery.of(context).size.width * 0.30,
          child: new Text(
            currentLocation == null ? "" : currentLocation,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        )
      ],
    );
  }
}
