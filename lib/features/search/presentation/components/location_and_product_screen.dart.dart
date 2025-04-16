import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velvet/core/data/cached/cache_helper.dart';
import 'package:velvet/core/services/location_service.dart';
import 'package:velvet/features/search/data/card_model.dart';
import 'package:velvet/features/search/widgets/adress_header.dart';
import 'package:velvet/features/search/widgets/product_grid.dart';
import 'package:velvet/features/search/widgets/google_map_view.dart';
import 'package:velvet/features/search/widgets/confirm_overlay.dart';

class LocationAndProductScreen extends StatefulWidget {
  const LocationAndProductScreen({super.key});
  static const routeName = '/locationWithProducts';

  @override
  State<LocationAndProductScreen> createState() =>
      _LocationAndProductScreenState();
}

class _LocationAndProductScreenState extends State<LocationAndProductScreen> {
  GoogleMapController? _mapController;
  final LocationService _locationService = LocationService();

  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  String? _address;
  bool _loading = false;
  bool _showMap = true;

  final List<ProductModel> _products = ProductModel.getDummyProducts();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _locationService.requestLocationPermission(
      context,
    );
    if (locationData != null) {
      final point = LatLng(locationData.latitude!, locationData.longitude!);
      setState(() {
        _currentLocation = point;
        _selectedLocation = point;
      });
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
      print("Fetching address for: ${point.latitude}, ${point.longitude}");
      final placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        print("Placemark found: $p");

        setState(() {
          _address = [
            if (p.name != null && p.name!.isNotEmpty) p.name,
            if (p.street != null && p.street!.isNotEmpty) p.street,
            if (p.subLocality != null && p.subLocality!.isNotEmpty)
              p.subLocality,
            if (p.locality != null && p.locality!.isNotEmpty) p.locality,
            if (p.administrativeArea != null &&
                p.administrativeArea!.isNotEmpty)
              p.administrativeArea,
            if (p.country != null && p.country!.isNotEmpty) p.country,
          ].join(', ');
        });
      } else {
        print("No placemarks found.");
        setState(() {
          _address = "تعذر الحصول على العنوان";
        });
      }
    } catch (e) {
      print("Geocoding error: $e");
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

  void _moveCamera(LatLng point) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(point, 15));
  }

  Future<void> _onConfirm() async {
    if (_selectedLocation != null && _address != null) {
      await CacheHelper.saveJson(
        key: 'user_location',
        json: {
          'address': _address!,
          'latitude': _selectedLocation!.latitude,
          'longitude': _selectedLocation!.longitude,
        },
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حفظ الموقع بنجاح')));

      setState(() {
        _showMap = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الموقع والمنتجات")),
      body: Stack(
        children: [
          Column(
            children: [
              if (!_showMap && _address != null)
                AddressHeader(address: _address!),
              ProductGrid(products: _products),
            ],
          ),
          if (_showMap && _currentLocation != null)
            GoogleMapView(
              currentLocation: _currentLocation!,
              selectedLocation: _selectedLocation,
              onMapTap: _onMapTap,
              onMapCreated: (controller) => _mapController = controller,
            ),
          if (_showMap)
            ConfirmOverlay(
              loading: _loading,
              address: _address,
              onConfirm: _onConfirm,
            ),
        ],
      ),
    );
  }
}
