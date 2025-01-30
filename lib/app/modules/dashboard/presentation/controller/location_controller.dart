import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
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

    // Get the current location
    final position = await Geolocator.getCurrentPosition();
    currentLocation.value = LatLng(position.latitude, position.longitude);
    locationName.value =
        await _getLocationName(position.latitude, position.longitude);

    // Move the map to the current location
    // _mapController.move(_currentLocation!, 15.0);

    // Listen to location changes
    Geolocator.getPositionStream().listen((Position position) async {
      currentLocation.value = LatLng(position.latitude, position.longitude);

      locationName.value =
          await _getLocationName(position.latitude, position.longitude);
      // _mapController.move(_currentLocation!, 15.0);
    });
  }

  Future<String> _getLocationName(double latitude, double longitude) async {
    // Use the geocoding package to get placemarks
    String response = "";
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      // Combine the name details (e.g., street, city, country)

      response =
          "${placemark.street}, ${placemark.locality}, ${placemark.country}";
    }

    return response;
    // } catch (e) {
    //   setState(() {
    //     locationName = "Error: Unable to fetch location name";
    //   });
    // }
  }

  getDestinationName(LatLng destinationGeo) async {
    destination.value = await _getLocationName(
        destinationGeo.latitude, destinationGeo.longitude);
  }
}
