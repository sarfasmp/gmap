import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gmapapp/data/api_endpoint.dart';
import 'package:gmapapp/data/network.dart';
import 'package:gmapapp/domain/models/custome_response_model.dart';
import 'package:gmapapp/domain/models/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<LocationModel> locationList = [];

  LocationModel? currentLocation;

  bool isFetchLocationLoading = false;

  ///Here the home page location api call limited data with count 30
  Future<void> onFetchLocationList() async {
    isFetchLocationLoading = true;
    notifyListeners();

    var data = {"limit": "50"};
    try {
      CustomResponse response = await ApiCallController.apiMethodSetup(
        method: ApiMethod.get,
        url: ApiEndpoints.locationList,
        data: data,
      );

      if (response.fullResponse != null) {
        print(response.fullResponse);

        locationList = locationModelFromJson(response.fullResponse);
        if (locationList.isNotEmpty) {
          coordinateToLocation();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  ///Method Using For Convert to Address

  Future<void> coordinateToLocation() async {
    try {
      for (var coordinates in locationList) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            (coordinates?.latitude ?? 0.0), (coordinates?.longitude ?? 0.0));

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String address = " ${place.locality}";
          coordinates.address = address;
        } else {
          coordinates.address = "";
        }
      }

      currentLocation = locationList.first;
      locationList.removeAt(0);

      isFetchLocationLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }

  ///Open Google Map
  void openGoogleMapsDirections({
    double? originLat,
    double? originLng,
    double? destinationLat,
    double? destinationLng,
  }) async {

    // The URL scheme for opening directions in Google Maps
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
