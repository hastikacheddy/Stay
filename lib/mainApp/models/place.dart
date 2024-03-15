import 'package:lotel/mainApp/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;

  Place({required this.geometry, required this.name});

  factory Place.fromJson(Map<String, dynamic> parsedJson) {
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['name']);
  }
}
