import 'package:weather_stations/data/core/api_client.dart';

import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';

abstract class WeatherRemoteDataSource {

  Future<CurrentWeatherModel> getCurrentWeatherAtGeoPoint({
    required double latitude, required double longitude
  });

  Future<ForecastWeatherModel> getFiveDaysForecast({
    required double latitude, required double longitude
  });
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {

  final APIClient client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentWeatherModel> getCurrentWeatherAtGeoPoint({
    required double latitude, required double longitude
  }) async {
    final response = await client.getCurrentWeather(latitude: latitude, longitude: longitude);
    return CurrentWeatherModel.fromJson(response);
  }

  @override
  Future<ForecastWeatherModel> getFiveDaysForecast({
    required double latitude, required double longitude
  }) async {
    final response = await client.getForecast(latitude: latitude, longitude: longitude);
    return ForecastWeatherModel.fromJson(response);
  }

}