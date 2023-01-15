import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';
import 'package:weather_stations/domain/repositories/weather_repository.dart';
import 'package:weather_stations/domain/usecases/usecase.dart';

class CurrentWeatherUseCase extends UseCase<CurrentWeatherModel, WeatherRequestParams> {

  final WeatherRepository weatherRepository;
  CurrentWeatherUseCase(this.weatherRepository);

  @override
  Future<CurrentWeatherModel> call(WeatherRequestParams params) async {
    return await weatherRepository
        .getCurrentWeatherAtGeoPoint(latitude: params.latitude, longitude: params.longitude);
  }

}