import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';
import 'package:weather_stations/domain/repositories/weather_repository.dart';
import 'package:weather_stations/domain/usecases/usecase.dart';

class ForecastWeatherUseCase extends UseCase<ForecastWeatherModel, WeatherRequestParams> {

  final WeatherRepository weatherRepository;
  ForecastWeatherUseCase(this.weatherRepository);

  @override
  Future<ForecastWeatherModel> call(WeatherRequestParams params) async {
    return await weatherRepository
        .getFiveDaysForecast(latitude: params.latitude, longitude: params.longitude);
  }

}