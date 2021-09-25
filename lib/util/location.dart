import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class Location {
  var local;
  // Map<String, dynamic> loc = {'lat': [], 'long': []};
  double lat;
  double long;
  double lat1;
  double long1;
  var dist;

  var latMax;
  var latMin;
  var longMax;
  var longMin;

  final Distance distance = new Distance();
  x() async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);
    print(placemark.toString());
  }

  distancia(fLat, fLong) {
    var x = fLat;
    var y = fLong;
    double km = distance.as(
        LengthUnit.Kilometer, LatLng(this.lat1, this.long1), LatLng(x, y));
    dist = km.toInt();
  }

  checkPositionStream() {
    new Geolocator()
        .getPositionStream(LocationOptions(accuracy: LocationAccuracy.high))
        .listen((event) {
      lat = event.latitude;
      long = event.longitude;
      latMax = lat - 20;
      latMin = lat + 20;
      longMax = long - 20;
      longMin = long + 20;
    });
  }

  postionActual() async {
    Position position = await new Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Map<String, dynamic> loc = {
      'latitude': position.latitude,
      'Longitude': position.longitude,
      'precisao': position.accuracy,
    };
    local = loc;
    lat1 = position.latitude;
    long1 = position.longitude;
    print(loc);
  }

  Future checkPosition(context) async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    postionActual();
    return geolocationStatus.value;
  }
}
