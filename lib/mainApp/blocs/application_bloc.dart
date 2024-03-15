import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lotel/mainApp/services/geolocator_service.dart';
import 'package:lotel/mainApp/services/marker_service.dart';
import 'package:lotel/mainApp/services/places_services.dart';

class Applicationbloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();

  //Variables

  Position? currentLocation;
  late List<Marker> markers;

  Applicationbloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();

    var places = await placesService.getPlaces(
        currentLocation!.latitude, currentLocation!.longitude);

    markers = [];

    if (places.isNotEmpty) {
      var newMarker = markerService.createMarkerFromPlace(places[0]);
      var newMarker2 = markerService.createMarkerFromPlace(places[2]);
      markers.add(newMarker);
      markers.add(newMarker2);
    }

    var _bounds = markerService.bounds(Set<Marker>.of(markers));

    bounds.add(_bounds!);
    notifyListeners();
  }
}
