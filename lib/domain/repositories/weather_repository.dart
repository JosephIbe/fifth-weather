import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';

abstract class WeatherRepository {

  Future<CurrentWeatherModel> getCurrentWeatherAtGeoPoint({
    required double latitude, required double longitude
  });

  Future<ForecastWeatherModel> getFiveDaysForecast({
    required double latitude, required double longitude
  });

}
