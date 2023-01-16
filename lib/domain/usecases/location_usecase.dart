import 'package:geolocator/geolocator.dart';
import 'package:weather_stations/domain/entities/no_params.dart';
import 'package:weather_stations/domain/repositories/location_repository.dart';
import 'package:weather_stations/domain/usecases/usecase.dart';

class LocationUseCase extends UseCase<Position, NoParams>{

  final LocationRepository locationRepository;
  LocationUseCase(this.locationRepository);

  @override
  Future<Position> call(NoParams params) async {
    return await locationRepository.getCurrentLocation();
  }

}