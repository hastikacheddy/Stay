import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lotel/mainApp/blocs/application_bloc.dart';
import 'package:lotel/mainApp/models/place.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<Applicationbloc>(context);
    return SafeArea(
      // ignore: unnecessary_null_comparison
      child: (applicationBloc.currentLocation == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              markers: Set<Marker>.of(applicationBloc.markers),
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(applicationBloc.currentLocation!.latitude,
                      applicationBloc.currentLocation!.longitude),
                  zoom: 16),
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(12.0, 75.0), zoom: 10)));
  }
}
