import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Rxn<LatLng?> currentLocation = Rxn<LatLng?>(null);
  Rxn<String?> locationName = Rxn<String?>(null);
  Rxn<String?> destination = Rxn<String?>(null);
  Rxn<LatLng?> destinationLatLng = Rxn<LatLng?>(null);
  Rxn<bool> showDestinationMarker = Rxn<bool>(false);

  Rxn<List<LatLng>> polyLines = Rxn<List<LatLng>>([]);

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    final position = await Geolocator.getCurrentPosition();
    currentLocation.value = LatLng(position.latitude, position.longitude);
    locationName.value =
        await _getLocationName(position.latitude, position.longitude);

    Geolocator.getPositionStream().listen((Position position) async {
      currentLocation.value = LatLng(position.latitude, position.longitude);

      locationName.value =
          await _getLocationName(position.latitude, position.longitude);
      // _mapController.move(_currentLocation!, 15.0);
    });
  }

  Future<String> _getLocationName(double latitude, double longitude) async {
    try {
      String response = "";
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        response =
            "${placemark.street}, ${placemark.locality}, ${placemark.country}";
      }

      return response;
    } catch (e) {
      return "Error: Unable to fetch location name";
    }
  }

  getDestinationName(LatLng destinationGeo) async {
    destination.value = await _getLocationName(
        destinationGeo.latitude, destinationGeo.longitude);
    showDestinationMarker.value = true;
    destinationLatLng.value = destinationGeo;
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    final String url =
        "http://router.project-osrm.org/route/v1/driving/${currentLocation.value?.longitude},${currentLocation.value?.latitude};${destinationLatLng.value?.longitude},${destinationLatLng.value?.latitude}?overview=full&geometries=geojson";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List coordinates = data['routes'][0]['geometry']['coordinates'];

      polyLines.value = coordinates
          .map(
            (coord) => LatLng(
              coord[1],
              coord[0],
            ),
          ) // Convert to LatLng
          .toList();
    }
  }
}
