import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';  // تأكد من استيراد هذا
import 'package:geocoding/geocoding.dart';
import 'package:velvet/core/data/cached/cache_helper.dart';
import 'package:velvet/core/services/location_service.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});
  static const routeName = '/locationPicker';

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  final LocationService _locationService = LocationService();

  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  String? _address;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _locationService.requestLocationPermission(context);
    if (locationData != null) {
      final point = LatLng(locationData.latitude!, locationData.longitude!);
      setState(() {
        _currentLocation = point;
        _selectedLocation = point;
      });

      // تحريك الكاميرا بعد رسم الخريطة
      _moveCamera(point);
      _getAddress(point);
    }
  }

  Future<void> _getAddress(LatLng point) async {
    setState(() {
      _loading = true;
      _address = null;
    });

    try {
      final placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          _address = "${p.name}, ${p.street}, ${p.locality}, ${p.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "تعذر الحصول على العنوان";
      });
    }

    setState(() {
      _loading = false;
    });
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _selectedLocation = point;
    });
    _getAddress(point);
    _moveCamera(point);
  }

  // تحريك الكاميرا إلى الموقع الجديد
  void _moveCamera(LatLng point) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(point, 15));
    }
  }

  Future<void> _onConfirm() async {
    if (_selectedLocation != null && _address != null) {
      await CacheHelper.saveJson(
        key: 'user_location',
        json: {
          'lat': _selectedLocation!.latitude,
          'lng': _selectedLocation!.longitude,
          'address': _address!,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ الموقع بنجاح')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختيار الموقع")),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation!,
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    setState(() {
                      _mapController = controller;  // تعيين المتحكم هنا
                    });
                  },
                  onTap: (latLng) => _onMapTap(latLng),
                  markers: _selectedLocation == null
                      ? {}
                      : {
                          Marker(
                            markerId: MarkerId("selected_location"),
                            position: _selectedLocation!,
                          ),
                        },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                        ),
                        child: _loading
                            ? const CircularProgressIndicator()
                            : Text(
                                _address ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _onConfirm,
                        child: const Text("تأكيد الموقع"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
