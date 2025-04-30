import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 0)
class LocationModel extends HiveObject {
  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lng;

  @HiveField(2)
  final String address;

  LocationModel({
    required this.lat,
    required this.lng,
    required this.address,
  });
}
