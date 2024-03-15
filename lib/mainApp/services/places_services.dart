import 'package:lotel/mainApp/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = "AIzaSyDUQof6WG2dQrZhGnKpXzv_daBBVo_7TSI";

  Future<List<Place>> getPlaces(double lat, double long) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?type=lodging&location=$lat,$long&rankby=distance&key=AIzaSyDUQof6WG2dQrZhGnKpXzv_daBBVo_7TSI';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;

    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
