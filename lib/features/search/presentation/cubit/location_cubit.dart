import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:velvet/core/services/location_manger.dart';
import 'location_state.dart';
import 'package:velvet/features/search/data/location_model.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationManager _locationManager;
  late final Box<LocationModel> _locationBox;
  late final ValueListenable<Box<LocationModel>> _boxListenable;

  LocationCubit(this._locationManager) : super(LocationInitial()) {
    _init();
  }

  Future<void> _init() async {

    _locationBox = Hive.box<LocationModel>('locationBox');
    _boxListenable = _locationBox.listenable();
    _boxListenable.addListener(_onBoxChanged);
    await loadSavedLocation(); // تحميل أولي للموقع
  }

  void _onBoxChanged() {
    final saved = _locationManager.getSavedLocation();
    if (saved != null) {
      emit(LocationLoaded(
        location: LatLng(saved.lat, saved.lng),
        address: saved.address,
      ));
    }
  }

  Future<void> loadSavedLocation() async {
    try {
      emit(LocationLoading());
      final saved = _locationManager.getSavedLocation();
      if (saved != null) {
        emit(LocationLoaded(
          location: LatLng(saved.lat, saved.lng),
          address: saved.address,
        ));
      } else {
        await getCurrentLocation();
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(LocationLoading());
      final locationModel = await _locationManager.fetchAndSaveCurrentLocation();
      if (locationModel != null) {
        emit(LocationLoaded(
          location: LatLng(locationModel.lat, locationModel.lng),
          address: locationModel.address,
        ));
      } else {
        emit(const LocationError("فشل الحصول على الموقع الحالي."));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> updateLocation(LatLng point) async {
    try {
      emit(LocationLoading());
      final locationModel = await _locationManager.updateLocation(point);
      emit(LocationLoaded(
        location: LatLng(locationModel.lat, locationModel.lng),
        address: locationModel.address,
      ));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _boxListenable.removeListener(_onBoxChanged);
    return super.close();
  }
}
