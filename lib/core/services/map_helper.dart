import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapHelper {
  static Future<String> getAddressFromLatLng(LatLng point) async {
    try {
      final placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return [
          if (p.street != null && p.street!.isNotEmpty) p.street,
          if (p.subLocality != null && p.subLocality!.isNotEmpty) p.subLocality,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality,
          if (p.administrativeArea != null && p.administrativeArea!.isNotEmpty) p.administrativeArea,
          if (p.country != null && p.country!.isNotEmpty) p.country,
        ].join(', ');
      } else {
        return "تعذر الحصول على العنوان";
      }
    } catch (e) { 
      return "تعذر الحصول على العنوان";
    }
  }

  static void moveCamera(GoogleMapController? controller, LatLng point, {double zoom = 15}) {
    controller?.animateCamera(CameraUpdate.newLatLngZoom(point, zoom));
  }
}
