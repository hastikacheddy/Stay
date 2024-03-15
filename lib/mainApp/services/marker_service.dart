import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lotel/mainApp/models/place.dart';

class MarkerService {
  LatLngBounds? bounds(Set<Marker> markers) {
    if (markers == null || markers.isEmpty) return null;

    return createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southWestLat = positions
        .map((p) => p.latitude)
        .reduce((value, element) => value < element ? value : element);

    final southWestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);

    final northEastLat = positions
        .map((p) => p.latitude)
        .reduce((value, element) => value > element ? value : element);

    final northEastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);

    return LatLngBounds(
        southwest: LatLng(southWestLat, southWestLon),
        northeast: LatLng(northEastLat, northEastLon));
  }

  Marker createMarkerFromPlace(Place place) {
    var markerId = place.name;

    return Marker(
      markerId: MarkerId(markerId),
      draggable: false,
      infoWindow: InfoWindow(
        title: place.name,
      ),
      position:
          LatLng(place.geometry.location.lat, place.geometry.location.lng),
    );
  }
}
