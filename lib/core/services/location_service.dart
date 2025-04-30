import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getCurrentLocationData() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return null;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    try {
      return await _location.getLocation();
    } catch (_) {
      return null;
    }
  }
}
