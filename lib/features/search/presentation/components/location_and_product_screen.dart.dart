import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velvet/core/services/location_manger.dart';
import 'package:velvet/core/services/location_service.dart';
import 'package:velvet/core/services/map_helper.dart';
import 'package:velvet/features/myFavourites/presentation/views/my_favourites.dart';
import 'package:velvet/features/search/data/location_model.dart';
import 'package:velvet/features/search/data/card_model.dart';
import 'package:velvet/features/search/presentation/widgets/adress_header.dart';
import 'package:velvet/features/search/presentation/widgets/product_grid.dart';
import 'package:velvet/features/search/presentation/widgets/google_map_view.dart';
import 'package:velvet/features/search/presentation/widgets/confirm_overlay.dart';

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
  late Box<LocationModel> _locationBox;
  late LocationManager _locationManager;

  @override
  void initState() {
    super.initState();
    _locationBox = Hive.box<LocationModel>('locationBox');
    _locationManager = LocationManager(_locationService, _locationBox);
    _loadSavedLocation();
  }

  void _loadSavedLocation() {
    final savedLocation = _locationManager.getSavedLocation();

    if (savedLocation != null) {
      setState(() {
        _address = savedLocation.address;
        _selectedLocation = LatLng(savedLocation.lat, savedLocation.lng);
        _showMap = false;
      });
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await _locationService.getCurrentLocationData();
    if (locationData != null) {
      final point = LatLng(locationData.latitude!, locationData.longitude!);
      setState(() {
        _currentLocation = point;
        _selectedLocation = point;
        _loading = true;
        _address = null;
      });

      MapHelper.moveCamera(_mapController, point);
      _address = await MapHelper.getAddressFromLatLng(point);

      setState(() {
        _loading = false;
      });
    }
  }

  void _onMapTap(LatLng point) async {
    setState(() {
      _selectedLocation = point;
      _loading = true;
      _address = null;
    });

    MapHelper.moveCamera(_mapController, point);
    _address = await MapHelper.getAddressFromLatLng(point);

    setState(() {
      _loading = false;
    });
  }

  Future<void> _onConfirm() async {
    if (_selectedLocation != null) {
      final location = await _locationManager.updateLocation(_selectedLocation!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ الموقع بنجاح')),
      );

      setState(() {
        _address = location.address;
        _showMap = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الموقع والمنتجات"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, MyFavouritesView.routeName);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (!_showMap && _address != null)
                Column(
                  children: [
                    AddressHeader(address: _address!),
                    TextButton.icon(
                      icon: const Icon(Icons.edit_location_alt),
                      label: const Text('تعديل العنوان'),
                      onPressed: () {
                        setState(() {
                          _showMap = true;
                        });
                      },
                    ),
                  ],
                ),
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
