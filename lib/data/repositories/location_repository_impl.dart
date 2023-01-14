import 'package:geolocator_platform_interface/src/models/position.dart';

import 'package:weather_stations/data/data_sources/location_data_source.dart';
import 'package:weather_stations/domain/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationDataSource dataSource;
  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Position> getCurrentLocation() async {
    return await dataSource.getCurrentLocation();
  }

}