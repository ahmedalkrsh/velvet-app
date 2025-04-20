import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatelessWidget {
  final LatLng currentLocation;
  final LatLng? selectedLocation;
  final Function(LatLng) onMapTap;
  final Function(GoogleMapController) onMapCreated;

  const GoogleMapView({
    super.key,
    required this.currentLocation,
    required this.selectedLocation,
    required this.onMapTap,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15,
        ),
        onMapCreated: onMapCreated,
        onTap: onMapTap,
        markers: selectedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("selected_location"),
                  position: selectedLocation!,
                ),
              },
      ),
    );
  }
}
