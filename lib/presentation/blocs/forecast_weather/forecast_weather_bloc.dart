import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/domain/weather_repository.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {

  final WeatherRepository _weatherRepository;

  ForecastWeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(ForecastWeatherStateInitial()) {
    on<GetWeatherForecast>(_getWeatherForecast);
  }

  void _getWeatherForecast(GetWeatherForecast event, Emitter<ForecastWeatherState> emit) async {
    emit(ForecastWeatherStateLoading());
    final data = await _weatherRepository
        .getFiveDaysForecast(latitude: event.latitude, longitude: event.longitude);
    print('getWeatherForecast data:\n$data');
    emit(ForecastWeatherStateSuccess(forecastWeatherModel: data));
  }

}