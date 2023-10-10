import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gmapapp/presentation/controller/home_screen_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    Key? key,
    this.polyLineLatAndLang,
  }) : super(key: key);

  final List<LatLng>? polyLineLatAndLang;

  @override
  Widget build(BuildContext context) {
    var homePro=Provider.of<HomeScreenProvider>(context);
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
        (polyLineLatAndLang?[0].latitude ?? 0.0),
        (polyLineLatAndLang?[0].longitude ?? 0.0),
      ),
      zoom: 100,
    );

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.my_location_outlined),
            onPressed: () async {

              homePro.openGoogleMapsDirections(
                destinationLat: (polyLineLatAndLang?[1].latitude ?? 0.0),
                destinationLng: (polyLineLatAndLang?[1].longitude ?? 0.0),
                originLat:  (polyLineLatAndLang?[0].latitude ?? 0.0),
                originLng: (polyLineLatAndLang?[0].longitude ?? 0.0),

              );

            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        polylines: {
          Polyline(
              polylineId: const PolylineId("PolyLine"),
              color: Colors.blue,
              points: (polyLineLatAndLang ?? []),
              width: 20)
        },
        markers: (polyLineLatAndLang ?? [])
            .map(
              (e) => Marker(
                markerId: const MarkerId("CURRENT"),
                position: LatLng(e.latitude, e.longitude),
              ),
            )
            .toSet(),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
