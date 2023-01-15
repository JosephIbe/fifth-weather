import 'package:weather_stations/data/data_sources/weather_remote_data_source.dart';

import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';

import 'package:weather_stations/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {

  final WeatherRemoteDataSource dataSource;
  WeatherRepositoryImpl({required this.dataSource});

  @override
  Future<CurrentWeatherModel> getCurrentWeatherAtGeoPoint({
    required double latitude, required double longitude
  }) async {
    return await dataSource.getCurrentWeatherAtGeoPoint(latitude: latitude, longitude: longitude);
  }

  @override
  Future<ForecastWeatherModel> getFiveDaysForecast({
    required double latitude, required double longitude
  }) async {
    return await dataSource.getFiveDaysForecast(latitude: latitude, longitude: longitude);
  }

}