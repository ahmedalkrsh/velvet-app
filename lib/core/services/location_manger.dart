import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:velvet/core/constansts/location_keys.dart';
import 'package:velvet/core/services/location_service.dart';
import 'package:velvet/core/services/map_helper.dart';

import '../../features/search/data/location_model.dart';

class LocationManager {
  final LocationService _locationService;
  final Box<LocationModel> _locationBox;

  LocationManager(this._locationService, this._locationBox);

  LocationModel? getSavedLocation() {
    return _locationBox.get(LocationKeys.userLocation);
  }

  Future<LocationModel?> fetchAndSaveCurrentLocation() async {
    final locationData = await _locationService.getCurrentLocationData();
    if (locationData != null) {
      final point = LatLng(locationData.latitude!, locationData.longitude!);
      final address = await MapHelper.getAddressFromLatLng(point);

      final locationModel = LocationModel(
        lat: point.latitude,
        lng: point.longitude,
        address: address,
      );

      await _locationBox.put(LocationKeys.userLocation, locationModel);
      return locationModel;
    }
    return null;
  }

  Future<LocationModel> updateLocation(LatLng point) async {
    final address = await MapHelper.getAddressFromLatLng(point);

    final locationModel = LocationModel(
      lat: point.latitude,
      lng: point.longitude,
      address: address,
    );

    await _locationBox.put(LocationKeys.userLocation, locationModel);
    return locationModel;
  }
}
